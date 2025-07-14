{{- define "your-chart.name" -}}
jira
{{- end }}

{{- define "your-chart.fullname" -}}
{{ .Release.Name }}
{{- end }}
