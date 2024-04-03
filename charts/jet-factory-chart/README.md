# jet-factory-chart
## Installation
### Edit $release_name.values.yaml
1. Set imageCredentials for image pulling

```yaml
# $release_name.values.yaml

imageCredentials: 
  registry: registry.cn-hangzhou.aliyuncs.com
  username: deploy-man@skylark
  password: changeit
```

2. Set image info for image pulling

```yaml
# $release_name.values.yaml

image:
  repository: jet/jet-factory
  tag: "latest"
  pullPolicy: IfNotPresent
```

3. Set host for app

```yaml
# $release_name.values.yaml

# Application
jetFactoryHost: factory.jet.localhost

# 此处设置数据库相关配置
database:
  host: postgresql
  port: "5432"
  user: postgres
  password: postgres
  database: factory
  # initcontainer 使用的 postgresql 镜像, 用于创建应用所需数据库
  image: postgres:latest
```

4. Set environments for app

```yaml
# $release_name.values.yaml

# jet-factory environment variable
env:
  SECRET_KEY_BASE: ""
  PHX_HOST: localhost
```

### Install

```bash
# set release-name install
helm install -f $release_name.values.yaml release-name ./
```

## HowTo

### Setup TLS

> 注：# 使用命令 `base64 -i tlsFile` 生成  `certificate` 与 `key` 的值

```yaml
# $release_name.values.yaml

jetFactoryTLSSecret:
  certificate: |-
    base64 encoded certificate
  key: |-
    base64 encoded key
```

### Uninstall

```bash
helm uninstall release-name
```

### Upgrade

```bash
helm upgrade -f $release_name.values.yaml release-name ./
```

### 指定 namespace 请使用一下参数

`--namespace jet-factory` : 指定名称空间

`--create-namespace` : 创建名称空间
