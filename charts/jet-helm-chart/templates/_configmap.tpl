{{/*
Build the breeze grpc address
*/}}
{{- define "jet-helm-chart.breezeAddress" -}}
{{- (printf "%s-breeze:50052" (include "jet-helm-chart.fullname" .)) -}}
{{- end }}

{{/*
Build the jet api endpoint
*/}}
{{- define "jet-helm-chart.jetApiEndpoint" -}}
{{- (printf "http://%s-project-man/api/plugin" (include "jet-helm-chart.fullname" .))}}
{{- end }}
