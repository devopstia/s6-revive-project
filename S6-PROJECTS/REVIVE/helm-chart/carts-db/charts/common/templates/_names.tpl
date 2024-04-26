{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "common.names.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.

You can override the name computation with .Values.fullnameOverride
*/}}
{{- define "common.names.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{-   .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{-   $name := default .Chart.Name .Values.nameOverride -}}
{{-   if contains $name .Release.Name -}}
{{-     .Release.Name | trunc 63 | trimSuffix "-" -}}
{{-   else -}}
{{-     printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{-   end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create service account name
*/}}
{{- define "common.names.serviceaccount" -}}
{{- if .Values.serviceAccount.create }}
{{-   default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{-   default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create image name

You can configure the registry name at the global level or at the project level, for example:

  global:
    imageRegistry: registry.acme.org

or,
  image:
    registry:   registry.acme.org
    repository: mylib/myapp

You can provide a tag at the project level or let the macro find the latest tag from the Chart Version (AppVersion):
  image:
    repository: mylib/myapp
or,
  image:
    repository: mylib/myapp
    tag:        1.0.2
*/}}
{{- define "common.names.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- if .Values.global -}}
{{-   $registryName = default $registryName .Values.global.imageRegistry -}}
{{- end -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $repositoryTag  := default .Chart.AppVersion .Values.image.tag | toString -}}
{{- if and $registryName (ne $registryName "none") }}
{{-   printf "%s/%s:%s" $registryName $repositoryName $repositoryTag -}}
{{- else }}
{{-   printf "%s:%s" $repositoryName $repositoryTag -}}
{{- end -}}
{{- end -}}

