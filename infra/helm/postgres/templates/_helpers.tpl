{{- define "postgres.name" -}}postgres{{- end -}}
{{- define "postgres.fullname" -}}{{ include "postgres.name" . }}{{- end -}}
{{- define "postgres.labels" -}}
app.kubernetes.io/name: {{ include "postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: krescue
{{- end -}}
