{{/*
Host for access rule
*/}}
{{- define "application-chart-template.applicationHosts" -}}
{{- $hosts := .Values.applicationHosts }}
{{- $orOperator := " || " }}
{{- $ruleHosts := list }}
{{- range $_, $host := $hosts }}
  {{- $ruleHosts = append $ruleHosts (printf "Host(`%s`)" $host) }}
{{- end }}
{{- printf "(%s)" (join $orOperator $ruleHosts) }}
{{- end }}

{{/*
Middlewares for web ingress-routes
*/}}
{{- define "application-chart-template.webMiddlewares" -}}
{{- $webMiddlewares := list "compress" "strip-prefix" }}
{{- if $.Values.applicationTLS }}
{{- $webMiddlewares = append $webMiddlewares "redirect-to-https" }}
{{- end }}
{{- if $.Values.corsSettings }}
{{- $webMiddlewares = append $webMiddlewares "cors" }}
{{- end }}
{{- range $webMiddlewares }}
- name: {{ include "application-chart-template.fullname" $ }}-{{ . }}
{{- end }}
{{- end }}

{{/*
Middlewares for websecure ingress-routes
*/}}
{{- define "application-chart-template.websecureMiddlewares" -}}
{{- $websecureMiddlewares := list "compress" "strip-prefix" }}
{{- if $.Values.corsSettings }}
{{- $websecureMiddlewares = append $websecureMiddlewares "cors" }}
{{- end }}
{{- range $websecureMiddlewares }}
- name: {{ include "application-chart-template.fullname" $ }}-{{ . }}
{{- end }}
{{- end }}

{{/*
Renders the ingress service port value
*/}}
{{- define "application-chart-template.ingressServicePort" -}}
{{- $portName := "" -}}
{{- range $port := .ports -}}
  {{- if eq $.servicePortName $port.name -}}
	{{- $portName = $.servicePortName -}}
	{{- end -}}
{{- end -}}
{{- if $portName -}}
{{- printf "%s" $portName -}}
{{- else -}}
{{- fail "The same service port name could not be found!" -}}
{{- end -}}
{{- end -}}
