{{/*
Expand the name of the chart.
*/}}
{{- define "jet-factory-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jet-factory-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jet-factory-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jet-factory-chart.labels" -}}
helm.sh/chart: {{ include "jet-factory-chart.chart" . }}
{{ include "jet-factory-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jet-factory-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jet-factory-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "jet-factory-chart.image" }}
{{- $registryName := .Values.imageCredentials.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}

{{/*
Return the DATABASE_URL
*/}}
{{- define "jet-factory-chart.database-url" }}
{{- $databaseUser := .Values.database.user -}}
{{- $databasePassword := .Values.database.password -}}
{{- $databaseHost := .Values.database.host -}}
{{- $databasePort := .Values.database.port -}}
{{- $databaseDatabase := .Values.database.database -}}
{{- printf "ecto://%s:%s@%s:%s/%s" $databaseUser $databasePassword $databaseHost $databasePort $databaseDatabase -}}
{{- end }}

