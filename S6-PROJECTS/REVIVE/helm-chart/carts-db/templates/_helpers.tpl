{{/* vim: set filetype=mustache: */}}
{{/*
Common labels
*/}}
{{- define "dynamodb-local.labels" -}}
{{- include "common.labels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dynamodb-local.selectorLabels" -}}
{{- include "common.selectorLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dynamodb-local.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{-   default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{-   default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Image name
*/}}
{{- define "dynamodb-local.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- if .Values.global -}}
{{-   $registryName = default $registryName .Values.global.imageRegistry -}}
{{- end -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag | toString -}}
{{- if and $registryName (ne $registryName "none") }}
{{-   printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else }}
{{-   printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

