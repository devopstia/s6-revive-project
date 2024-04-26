{{/*
Expand the name of the chart.
*/}}
{{- define "expresso-shop-reviews.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "expresso-shop-reviews.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "expresso-shop-reviews.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "expresso-shop-reviews.labels_01" -}}
helm.sh/chart: {{ include "expresso-shop-reviews.chart" . }}
{{ include "expresso-shop-reviews.selectorLabels_01" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{/*


*/}}
{{- define "expresso-shop-reviews.labels_02" -}}
helm.sh/chart: {{ include "expresso-shop-reviews.chart" . }}
{{ include "expresso-shop-reviews.selectorLabels_02" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{/*





Selector labels
*/}}
{{- define "expresso-shop-reviews.selectorLabels_01" -}}
version: v1
app.kubernetes.io/name: {{ include "expresso-shop-reviews.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


*/}}
{{- define "expresso-shop-reviews.selectorLabels_02" -}}
version: v2
app.kubernetes.io/name: {{ include "expresso-shop-reviews.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "expresso-shop-reviews.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "expresso-shop-reviews.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
