# jet-helm-chart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A jet helm chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| YangKe | <yangke@jet.work> |  |

## Source Code

* <https://github.com/Byzanteam/jet-helm-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | projectmandb(postgresql) | 12.5.7 |
| https://charts.bitnami.com/bitnami | dynamicdb(postgresql) | 12.5.7 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| existingJetSecret | string | `"jet-env-secret"` | 已创建的 secret 名称 |
| image.registry | string | `"registry.cn-hangzhou.aliyuncs.com"` | 镜像仓库地址 |
| image.existImageSecrets | string | `""` | 已存在的镜像拉取凭证 secret |
| projectMan.image.pullPolicy | string | `"IfNotPresent"` | 镜像拉取策略 |
| projectMan.image.repository | string | `"jet/project_man"` |  |
| projectMan.image.tag | string | `"latest"` |  |
| projectMan.env.RELEASE_COOKIE | string | `"cookie"` |  |
| projectMan.env.RELEASE_NODE | string | `"sname"` |  |
| projectMan.env.PROJECT_MAN_DYNAMIC_REPO_EXPOSED_HOSTNAME | string | `"dynamic_prod"` | 项目数据库对外时的主机名 |
| projectMan.env.PROJECT_MAN_DYNAMIC_REPO_EXPOSED_PORT | string | `"5432"` | 项目数据库对外时的端口 |
| projectMan.env.PROJECT_MAN_API_HOST | string | `"project_man"` |  |
| projectMan.env.PLUGIN_API_HOST | string | `"project_man"` |  |
| projectMan.env.PROJECT_MAN_ECTO_IPV6 | string | `"false"` | 决定 ecto 连接是否使用 IPv6 |
| projectMan.env.TRACE_AWARE_ECTO_IPV6 | string | `"false"` | 决定 ecto 连接是否使用 IPv6 |
| projectMan.replicaCount | int | `1` |  |
| projectMan.resources | object | `{}` |  |
| projectMan.nodeSelector | object | `{}` |  |
| projectMan.tolerations | list | `[]` |  |
| projectMan.affinity | object | `{}` |  |
| breeze.image.pullPolicy | string | `"IfNotPresent"` |  |
| breeze.image.repository | string | `"jet/breeze"` |  |
| breeze.image.tag | string | `"latest"` |  |
| breeze.replicaCount | int | `1` |  |
| breeze.resources | object | `{}` |  |
| breeze.nodeSelector | object | `{}` |  |
| breeze.tolerations | list | `[]` |  |
| breeze.affinity | object | `{}` |  |
| hosts | list | `[]` | jet 的访问地址 |
| certificate | object | `{}` | tls 证书 |
| ingressroute.subpath | string | `""` | jet 子路径 |
| ingressroute.middlewares.corsSettings | object | `{}` | 跨域配置 |
| backup | object | `{}` | 数据库备份设置 |
| projectmandb.enabled | bool | `false` | 是否部署 projectmandb 数据库 |
| projectmandb.primary.extendedConfiguration | string | `""` | 扩展 PostgreSQL 主配置（附加到主配置或默认配置）|
| projectmandb.primary.initdb.scripts | object | `{}` | initdb 脚本字典 |
| projectmandb.primary.persistence.enabled | bool | `false` | 使用PVC启用PostgreSQL主数据持久化 |
| projectmandb.primary.pgHbaConfiguration | string | `""` | PostgreSQL 主客户端身份验证配置 |
| projectmandb.shmVolume.sizeLimit | string | `"5Gi"` | 设置此项以启用 shm tmpfs 的大小限制 |
| dynamicdb.enabled | bool | `false` | 是否部署 dynamicdb 数据库 |
| dynamicdb.primary.extendedConfiguration | string | `""` | 扩展 PostgreSQL 主配置（附加到主配置或默认配置）|
| dynamicdb.primary.initdb.scripts | object | `{}` | 指定 PostgreSQL 密码以执行 initdb 脚本 |
| dynamicdb.primary.persistence.enabled | bool | `false` | 使用PVC启用PostgreSQL主数据持久化 |
| dynamicdb.primary.pgHbaConfiguration | string | `""` | PostgreSQL 主客户端身份验证配置 |
| dynamicdb.shmVolume.sizeLimit | string | `"5Gi"` | 设置此项以启用 shm tmpfs 的大小限制 |

----------------------------------------------

## Usage

### Prerequisites

- Helm v3 [installed](https://helm.sh/docs/using_helm/#installing-helm)
- Add `traefik` and `bitnami` repo
- Install `traefik`
- `helm dependency update`

### 使用前请编写 jet-env-secret.yaml 文件

### 1. 设置 secret 参数

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: jet-env-secret
  namespace: # 与 jet 应用同一个 namespace
type: Opaque
data:
  project-man-ecto-credential-secret: cnl6V1lCdFRYcS9hNlVVaUxuUWpGWGlTNUQzcC9IUzlHb3FMRzlxYmlzYkthL3BDeDcrUEFsMTJTWEEwSkU0dAo=
  project-man-plugin-jwt-private-key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRREIvN01pamt4ZXFodWEKSkJINmdHYmNmQkYxSThETlpzM2ZWa0hpaWVQVmdpc2ZGUmRtK3pQYTlSb0hCdFVNcVdOcVIzZ2VQcnhrNkw4cgpIaExWVlZMazhOb0Z6c3k1UWtVRjc1bmhaRURZMEtIcGl1dTVpSWVENndLSE9CYVQ5NGhJRWRmV1NGdUVhY0JUCkpWMk1BaktyWWkzdmc2K21JWFBVaTVwdmRReEZjb0tQaFVYOS9VR3BUblMyR1hUZSt2VStzQWN0K1pHdTJsNm4KNUg1WllHZGV3VHpYSGI4UkFGQTBTbHY5TlFnallBV0NWWTA2andRMGxvZVo4NXI2eTdkYUxoY0J1eWRTVXhucQpjRDBVMWhINGRad1gxcXdGZEtJaFhvdGpHTnJqd25rUExKK0tML2ZZeFVnTExxZWN1R3c2LzFhNnlSdjhVRFJDCnlpY3FYZjc5QWdNQkFBRUNnZ0VBQnJwWVJlVUZ6S3luNjJjVks5NVljdUlSOVpiZXEyRHdMUzdWSWNiNEhLSDQKaVRTV2pLN3BPVTZSeEt6ekpqbHVVTFBDSnk1ZXplaHRKTkRVcjJCWHBuS2NqN2RWemV1alJZQkRQUmdESmJjZgo2UXBmMVhNMk1VTFh0Mi9MQjFPbzFCMnc5Mlg5Vjl0cnNrRXBVWW5oVHZueDJqZHpiU3dHS1M0SmxqNzFiMzBUCklpNkY2MkFjM0I3bWVMR21ZOTZBWFpvSGVEQ2dhalhXUEFrdGo5SGJ2eCtZVnlZS2FRTG4xei9tWmlkV1ByeFoKR09UZDVwUWVIN3FyZ0EwT0JqSG5pNy9WcmtmTjU5RURuQlA2WW54S2NhQ0ZwQXFsSzNTOU9XNTJNNXBxZnFxWApDQkorMlJyMUh3dU5VZUhxZGdNbHp5dUtaNnE0eXlFR3dWVGFLa3NsQVFLQmdRRDFBMExjWXYxdjl0STcrRWUrCkxBMnVJbjhHMmp3UUlnV3pRN29VR09vL0tuL083OEMvYThtbDNabkc4U281VjFPRTgrc1BwNElUR3RVUE1Tci8KMVdmdjMvdm02c3R0Q3RKRWZkM2E1d293eHZmc3BYNFp5aDRQVy9PdzRONGVucVBlLy9OY1UwUGN5RXVXeFF5QwpXTDRObnhlWVpRRnBDaHBONjREdUNLRzZmUUtCZ1FES3Nzem5nVWNEN0w2U2FDcGlvanRKMXR1WTdDbHF4MXFLCngzRzlTRnJmaWJuRHpFQWV0VHA1WE5Ic2s3UDFoRGNGbHBZSE9HQ2s1dFNjZHhBeUd0UXkrRWtLczE1MjFjVWUKRUNuMDN2aEkwNWhQNHorMklkRmhsajF5WHQ0ZXIwbDVmV0NlWEx1dlQyWmZQdVh3NzU4QlhqTEV3Q3NIVHIzVApUWXkvZ2VQK2dRS0JnUURjTVV3YmFGTkFGbUFtU1NHZ3hWS2VGcDUyZUJiV29OemltSkZZa25PaXhQMEw2dWdjCm9EQWZBcUs2NmUzNmpvS2V6OStHdUJIc1BZY1JHaXo4c3J1d0ZtbjZ3elNERU9DYmNVcTYranhzVGNSdVJ1U24KSk1BVEtaNCtiamp3NTcxNklpaUI1c3JzVm8yb04vcmdBZ1Q3bE9qTnFxaXp6OEtJR0loTVpER0V1UUtCZ0VGRgpzcFlhR3pRNFdHWHRCVGtkNU5teVJxVEg1ODVxdzgxTXpHT1htU3ZDdmY4L0ZxYk0xVGVmbkRvQ2xrREpncTVaCi81WHpvYXQ0YVo2NCtJNHA5WXMwU05FWlVhSVMxSmNKdlhrTkZBYmZuSHlkUVRiMVRPZVA2ZG1ha3d4dWhjcUoKaFVONXVUYUs2dnhnMU1yeFh0S2g4dGRJeXBKZjJPRGlhQ0NEUTFnQkFvR0FaeFMvbmkwZjNNWTZ5V1VPc2p3aApsbWhxbHNlY0lhOVdFM2FPaFoxeTJQRWEwTksyRG9KVkZ4bWNzUFNqYkVrUktFRERXNjI5endtQzJRVlFaWWxPCkZYcXhaWXdnOEhKcEYvNmIvN3FzOU96QzltZ2FpRjFFYURSenNaZXRvWGsxZ29UY0dQWXlFZHNWY1ovQ0Uxb28KRDFPM2pyenFSM3QzeW9YM0x0OTBGdU09Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K
  project-man-api-secret-key-base: U2w3eW0va0RteEw3bWNaemtZN1MvekxFUDlZYmtwNGFxVG5FL0JvSFFmc0dBd25LcVFhS2Z5eldQczRwQWViVSAtbgo=
  plugin-api-secret-key-base: U2w3eW0va0RteEw3bWNaemtZN1MvekxFUDlZYmtwNGFxVG5FL0JvSFFmc0dBd25LcVFhS2Z5eldQczRwQWViVSAtbgo=
  trace-aware-database-url: ZWN0bzovL3Bvc3RncmVzOmNoYW5nZWl0QGpldC1wb3N0Z3Jlc3FsL3RyYWNlX2F3YXJlX3Byb2Q==
  project-man-database-url: ZWN0bzovL3Bvc3RncmVzOmNoYW5nZWl0QGpldC1wb3N0Z3Jlc3FsL3Byb2plY3RfbWFuX3Byb2Q==
  project-man-dynamic-database-url: ZWN0bzovL3Bvc3RncmVzOmNoYW5nZWl0QGR5bmFtaWMtcG9zdGdyZXNxbC9keW5hbWljX3Byb2Q=
```
> 参数解释如下：
> ```yaml
> # 用于加密应用数据库密码的密钥（`openssl rand -base64 48`）
> project-man-ecto-credential-secret: "AU27PtMelV3aojYkOgvYIJjnBoQ5gRhRFuYYOeLVZ8XbG7V3S8GRvSB0pT14qwpj"
> # Jet 用于签名 JWT 的 RSA 私钥（`openssl genrsa 2048`）
> project-man-plugin-jwt-private-key: "-----BEGIN PRIVATE KEY-----
> MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB/7Mijkxeqhua
> JBH6gGbcfBF1I8DNZs3fVkHiiePVgisfFRdm+zPa9RoHBtUMqWNqR3gePrxk6L8r
> HhLVVVLk8NoFzsy5QkUF75nhZEDY0KHpiuu5iIeD6wKHOBaT94hIEdfWSFuEacBT
> JV2MAjKrYi3vg6+mIXPUi5pvdQxFcoKPhUX9/UGpTnS2GXTe+vU+sAct+ZGu2l6n
> 5H5ZYGdewTzXHb8RAFA0Slv9NQgjYAWCVY06jwQ0loeZ85r6y7daLhcBuydSUxnq
> cD0U1hH4dZwX1qwFdKIhXotjGNrjwnkPLJ+KL/fYxUgLLqecuGw6/1a6yRv8UDRC
> yicqXf79AgMBAAECggEABrpYReUFzKyn62cVK95YcuIR9Zbeq2DwLS7VIcb4HKH4
> iTSWjK7pOU6RxKzzJjluULPCJy5ezehtJNDUr2BXpnKcj7dVzeujRYBDPRgDJbcf
> 6Qpf1XM2MULXt2/LB1Oo1B2w92X9V9trskEpUYnhTvnx2jdzbSwGKS4Jlj71b30T
> Ii6F62Ac3B7meLGmY96AXZoHeDCgajXWPAktj9Hbvx+YVyYKaQLn1z/mZidWPrxZ
> GOTd5pQeH7qrgA0OBjHni7/VrkfN59EDnBP6YnxKcaCFpAqlK3S9OW52M5pqfqqX
> CBJ+2Rr1HwuNUeHqdgMlzyuKZ6q4yyEGwVTaKkslAQKBgQD1A0LcYv1v9tI7+Ee+
> LA2uIn8G2jwQIgWzQ7oUGOo/Kn/O78C/a8ml3ZnG8So5V1OE8+sPp4ITGtUPMSr/
> 1Wfv3/vm6sttCtJEfd3a5wowxvfspX4Zyh4PW/Ow4N4enqPe//NcU0PcyEuWxQyC
> WL4NnxeYZQFpChpN64DuCKG6fQKBgQDKsszngUcD7L6SaCpiojtJ1tuY7Clqx1qK
> x3G9SFrfibnDzEAetTp5XNHsk7P1hDcFlpYHOGCk5tScdxAyGtQy+EkKs1521cUe
> ECn03vhI05hP4z+2IdFhlj1yXt4er0l5fWCeXLuvT2ZfPuXw758BXjLEwCsHTr3T
> TYy/geP+gQKBgQDcMUwbaFNAFmAmSSGgxVKeFp52eBbWoNzimJFYknOixP0L6ugc
> oDAfAqK66e36joKez9+GuBHsPYcRGiz8sruwFmn6wzSDEOCbcUq6+jxsTcRuRuSn
> JMATKZ4+bjjw5716IiiB5srsVo2oN/rgAgT7lOjNqqizz8KIGIhMZDGEuQKBgEFF
> spYaGzQ4WGXtBTkd5NmyRqTH585qw81MzGOXmSvCvf8/FqbM1TefnDoClkDJgq5Z
> /5Xzoat4aZ64+I4p9Ys0SNEZUaIS1JcJvXkNFAbfnHydQTb1TOeP6dmakwxuhcqJ
> hUN5uTaK6vxg1MrxXtKh8tdIypJf2ODiaCCDQ1gBAoGAZxS/ni0f3MY6yWUOsjwh
> lmhqlsecIa9WE3aOhZ1y2PEa0NK2DoJVFxmcsPSjbEkRKEDDW629zwmC2QVQZYlO
> FXqxZYwg8HJpF/6b/7qs9OzC9mgaiF1EaDRzsZetoXk1goTcGPYyEdsVcZ/CE1oo
> D1O3jrzqR3t3yoX3Lt90FuM=
> -----END PRIVATE KEY-----"
> # Phoenix 用于生成会话密码的密钥（`openssl rand -base64 48`）
> project-man-api-secret-key-base: "Sl7ym/kDmxL7mcZzkY7S/zLEP9Ybkp4aqTnE/BoHQfsGAwnKqQaKfyzWPs4pAebU"
> plugin-api-secret-key-base: "Sl7ym/kDmxL7mcZzkY7S/zLEP9Ybkp4aqTnE/BoHQfsGAwnKqQaKfyzWPs4pAebU"
> # Trace Aware 数据库连接地址,格式：ecto://USER:PASS@HOST/DATABASE
> trace-aware-database-url: "ecto://postgres:changeit@jet-postgresql/project_man_prod"
> # Jet 数据库连接地址,格式：ecto://USER:PASS@HOST/DATABASE
> project-man-database-url: "ecto://postgres:changeit@jet-postgresql/project_man_prod"
> # 项目数据库连接地址,格式：ecto://USER:PASS@HOST/DATABASE
> project-man-dynamic-database-url: "ecto://postgres:changeit@dynamic-postgresql/dynamic_prod"
> ```
> :warning: 使用 base64 编码后填入 secret 资源文件对应 key 中

### 使用前请编写 release.values.yaml 文件

### 1. 设置镜像相关信息

```yaml
projectMan:
  image:
    repository: jet/project_man
    pullPolicy: IfNotPresent
    tag: "latest"
breeze:
  image:
    repository: jet/breeze
    pullPolicy: IfNotPresent
    tag: "latest"
```

### 2. 设置拉取镜像凭证

```yaml
image:  
  # 使用已存在的仓库凭证
  existImageSecrets: ""
```

> [创建镜像拉取凭证说明](https://kubernetes.io/docs/concepts/configuration/secret/#docker-config-secrets)

### 3. 设置环境变量

```yaml
projectMan:
  env:
    RELEASE_NODE: sname
    RELEASE_COOKIE: cookie
    # 项目数据库对外时的主机名
    PROJECT_MAN_DYNAMIC_REPO_EXPOSED_HOSTNAME: dynamic_prod
    # 项目数据库对外时的端口
    PROJECT_MAN_DYNAMIC_REPO_EXPOSED_PORT: "5432"
    PROJECT_MAN_API_HOST: project_man
    PLUGIN_API_HOST: project_man
    # 决定 ecto 连接是否使用 IPv6
    PROJECT_MAN_ECTO_IPV6: "false"
    TRACE_AWARE_ECTO_IPV6: "false"
```

### 4. 设置访问的 `hosts`

```yaml
hosts:
  - example.jet.com
  - 10.0.0.1
```

### 5. 设置 TLS 证书

```yaml
certificate:
  # 使用证书挑战
  certResolver: jet
  
  # 使用已有证书 secret 资源
  tlsSecretName: ""
```

> TLS 证书设置其中一个参数即可

## Misc

### 1. 数据库依赖配置

- 启用数据库前手动添加 dependency-db-secret.yaml 文件

  ```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: dependency-db-secret
    namespace: # 与 jet 应用同一个 namespace
  type: Opaque
  data:
    project-man-password: ZmE5OWUyNGU0OTJhZjg4NTZmMDE=
    dynamic-password: ZmE5OWUyNGU0OTJhZjg4NTZmMDE=
  ```
  
  > :warning: 使用 base64 编码密码后设置给对应的 `project-man-password`  变量
  
- 设置数据库启用与数据持久化

  ```yaml
  # release.values.yaml
  projectmandb:
    enabled: true
    persistence:
       enabled: true
       existingClaim: # 创建好的 PVC 名称
  dynamicdb:
    enabled: true
    persistence:
       enabled: true
       existingClaim: # 创建好的 PVC 名称
  ```

> :warning:[数据库详细配置](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#parameters)

### 2. 应用跨域设置

```yaml
# release.values.yaml
ingressroute:
  middlewares:
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

### 3. 备份设置

```yaml
# release.values.yaml

# 使用velero备份数据库
backup:
  # 设置数据库的自动备份。格式为“分、时、日、月、周”。
  veleroSchedule: "0 1 * * *"
  # 设置需要备份的名称空间。
  includeNamespaces:
    - production
    - database
    - ...
  # 指定需要备份的应用程序的标签。
  selector:
    app.kubernetes.io/instance: postgresql
  # [可选参数]指定备份的存储位置。
  storageLocation: backup
  # 设置备份的生存时间(ttl)。
  ttl: "720h0m0s"
```

### 4. backup operation guide
- 根据 `schedule` 创建备份
```bash
velero create backup $backup_name --from-schedule $schedule_name
```
- 列出备份
```bash
velero get backup
```
- 查看备份详情
```bash
velero describe backups $backup_name --details
```
> $backup_name和$schedule_name按实际填写

### 5. Subpath 支持
```yaml
# release.values.yaml
ingressroute:
  subpath: /jet
```
