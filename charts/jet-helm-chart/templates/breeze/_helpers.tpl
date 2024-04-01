{{/*
Return the breeze image name
*/}}
{{- define "jet-helm-chart.breezeImage" }}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.breeze.image.repository -}}
{{- $tag := .Values.breeze.image.tag | toString -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}

{{/*
breeze labels
*/}}
{{- define "jet-helm-chart.breezeLabels" -}}
helm.sh/chart: {{ include "jet-helm-chart.chart" . }}
{{ include "jet-helm-chart.breezeSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for breeze
*/}}
{{- define "jet-helm-chart.breezeSelectorLabels" -}}
{{ include "jet-helm-chart.selectorLabels" . }}
app.kubernetes.io/application: breeze
{{- end }}
