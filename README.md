# Byzanteam Helm Chart Repository

Welcome to byzanteam helm chart repository!

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

## Once Helm has been set up correctly, add the repo as follows:

`helm repo add Byzanteam https://Byzanteam.github.io/helm-charts`


>If you had already added this repo earlier, run `helm repo update` to retrieve
>
>the latest versions of the packages.  You can then run `helm search repo
>
>Byzanteam` to see the charts.

## To install the <chart-name> chart:

    helm install my-<chart-name> Byzanteam/helm-charts

## To uninstall the chart:

    helm delete my-<chart-name>

