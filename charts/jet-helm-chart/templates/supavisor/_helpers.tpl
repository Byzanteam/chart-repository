{{/*
Return the supavisor image name
*/}}
{{- define "jet-helm-chart.supavisorImage" }}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.supavisor.image.repository -}}
{{- $tag := .Values.supavisor.image.tag | toString -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}

{{/*
supavisor labels
*/}}
{{- define "jet-helm-chart.supavisorLabels" -}}
helm.sh/chart: {{ include "jet-helm-chart.chart" . }}
{{ include "jet-helm-chart.supavisorSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for supavisor
*/}}
{{- define "jet-helm-chart.supavisorSelectorLabels" -}}
{{ include "jet-helm-chart.selectorLabels" . }}
app.kubernetes.io/application: supavisor
{{- end }}

{/*
Build secret keys
*/}
{{- define "jet-helm-chart.supavisorSecretKeys" -}}
{{- $keys := list }}
{{- $keys = append $keys (dict "envName" "DATABASE_URL" "secretKeyName" "supavisor-database-url") }}
{{- $keys = append $keys (dict "envName" "SECRET_KEY_BASE" "secretKeyName" "supavisor-secret-key-base") }}
{{- $keys = append $keys (dict "envName" "VAULT_ENC_KEY" "secretKeyName" "supavisor-vault-enc-key") }}
{{- $keys = append $keys (dict "envName" "API_JWT_SECRET" "secretKeyName" "supavisor-api-jwt-secret") }}
{{- $keys = append $keys (dict "envName" "METRICS_JWT_SECRET" "secretKeyName" "supavisor-metrics-jwt-secret") }}
{{- range $key := $keys }}
- name: {{ $key.envName | quote }}
  valueFrom:
    secretKeyRef:
      name: {{ $.Values.existingJetSecret }}
      key: {{ $key.secretKeyName | quote }}
{{- end }}
{{- end }}
