{{- define "minio.name" -}}minio{{- end -}}
{{- define "minio.fullname" -}}{{ include "minio.name" . }}{{- end -}}
{{- define "minio.labels" -}}
app.kubernetes.io/name: {{ include "minio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: krescue
{{- end -}}
