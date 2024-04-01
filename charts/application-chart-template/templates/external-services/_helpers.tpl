{{/*
Create external-service name.
*/}}
{{- define "application-chart-template.external-service-name" -}}
{{- $fullname := include "application-chart-template.fullname" .root }}
{{- printf "%s-%s" $fullname .service.name | trimSuffix "-" }}
{{- end }}
