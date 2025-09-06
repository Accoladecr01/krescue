{{- define "sampleapp.name" -}}sample-app{{- end -}}
{{- define "sampleapp.fullname" -}}{{ include "sampleapp.name" . }}{{- end -}}
{{- define "sampleapp.labels" -}}
app.kubernetes.io/name: {{ include "sampleapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: krescue
{{- end -}}
