# application-chart-template

![Version: 1.4.0](https://img.shields.io/badge/Version-1.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart template for byzanteam application

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| YangKe | <yangke@jet.work> |  https://Byzanteam.github.io/helm-charts |

## Source Code

* <https://github.com/Byzanteam/application-chart-template/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appIngressroutes | list | `[]` |  |
| applicationHosts | list | `[]` |  |
| applicationTLS | object | `{}` |  |
| corsSettings | object | `{}` |  |
| envFromSecrets[].existSecretName | string | `""` | The secret resource name |
| envFromSecrets[].env[].envName | string | `""` | The env name |
| envFromSecrets[].env[].secretKey | string | `""` | The secret key name in the resource |
| env | object | `{}` |  |
| externalIngressroute | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nginx"` |  |
| image.tag | string | `"latest"` |  |
| imageCredentials | object | `{}` |  |
| initContainers | list | `[]` |  |
| nameOverride | string | `""` |  |
| replicaCount | int | `1` |  |
| restartPolicy | string | `"Always"` |  |
| service.ports[].name | string | `"http"` |  |
| service.ports[].port | int | `80` |  |
| service.ports[].protocol | string | `TCP` |  |
| service.type | string | `"ClusterIP"` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| command | list | `[]` |  |


----------------------------------------------

## 使用前请编写 release.values.yaml 文件

### 1. 设置拉取镜像 name 与 tag
```yaml
image:
  repository: registory/namespace/name
  pullPolicy: IfNotPresent
  tag: "latest"
```
### 2. 设置拉取镜像凭证
```yaml
imageCredentials:
  registry: registry.cn-hangzhou.aliyuncs.com
  username: deploy-man@skylark
  password: changeit
```
### 3. 设置 application hosts(支持域名和IP)
```yaml
applicationHosts:
  - example.com
  - 192.168.0.1
```
### 4. 设置反向代理对应 path 规则
```yaml
appIngressroutes:
  - name: example-name
    path: /example-path
    servicePortName: 0
```
### 5. 设置外部服务代理规则

```yaml
externalIngressroute:
  - name: "external-name"
    # 外部服务是域名则用 host
    host: "external-host"
    # 外部服务是 ip 则用 ip
    ip: "192.168.0.1"
    port: "443"
    path: "/external-path"
    # 映入外部服务所需要添加的中间件
    middlewares:
      - cors-header
```
> 注： 外部服务所用中间件 `cors-header` 目的是给前端调用第三方服务时使用

### 6. 设置应用需要的 env 参数
```yaml
env: {}
```
### 7. 应用需要使用 https 时设置
> 使用证书挑战设置 `certResolver` 参数
```yaml
applicationTLS:
  certResolver: jet
```
> 使用自有证书设置 `TLSSecret`
```yaml
applicationTLS:
  TLSSecret:
    certificate: certificate-file base64 encoding
    key: key-file base64 encoding
```

### 8. 设置已存在的 secret 资源作为环境变量
```yaml
envFromSecrets:
  - existSecretName: "jet-env-secret"
    env:
      - envName: "LOG_LEVEL"
        secretKey: "jet_plugin_level"
```
> secret内容如下：
>
> ```yaml
>apiVersion: v1
> kind: Secret
> metadata:
>   name: example-env-secret
> type: Opaque
>   data:
>   example-key1: TnV6YUNYQTlZUUxMOWI= # base64 encoding string
>   example-key2: aYnlwd1VpcFNlb1FIMVR # base64 encoding string
>   ```

## Misc
### 应用启动初始化设置
```yaml
initContainers:
  - name: init
    image: busybox:latest
    command: ["sh", "-c"]
    args: []
    envFrom:
       - configMapRef:
           name: {{ include "application-chart-template.name" $ }}-env
```

### image command 覆盖
```yaml
command:
  - /bin/sh
  - -c
```

### 应用文件挂载设置
```yaml
volumeMounts:
  - mountPath: /path/file
    name: volumeName

volumes:
  - name: volumeName
    hostPath:
      path: /local/path
      type: DirectoryOrCreate
```

### 应用跨域设置

```yaml
corsSettings:
  accessControlAllowHeaders:
    - '*'
  accessControlAllowMethods:
    - GET
    - OPTIONS
    - PUT
  accessControlAllowOriginList:
    - '*'
  accessControlMaxAge: "100"
```

### 调度设置

- nodeSelector
```yaml
nodeSelector:
  key: value
```

- tolerations
```yaml
tolerations:
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoSchedule"
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoExecute"
```
> [参数说明](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/taint-and-toleration/#concepts)

- affinity

```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/os
          operator: In
          values:
          - linux
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 1
      preference:
        matchExpressions:
        - key: label-1
          operator: In
          values:
          - key-1
    - weight: 50
      preference:
        matchExpressions:
        - key: label-2
          operator: In
          values:
          - key-2
```

> [参数说明](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity)
