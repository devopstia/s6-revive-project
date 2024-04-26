{{/* vim: set filetype=mustache: */}}
{{/*
  Logging level
  @description: The Default logging level
  @author     : gildas@breizh.org
  @default    : INFO
  @values     :
    - TRACE
    - DEBUG
    - INFO
    - WARN
    - ERROR
    - FATAL
    - NEVER
  @usage: You can configure this value at the global level or at the project level, for example:

    global:
      logging:
        level: DEBUG

  or:

    logging:
      level: DEBUG

  Then, your Deployment template, just include this helper:

    containers:
      - name: my-container
        env:
          - name: LOG_LEVEL
            value: {{ include "common.logging.level" . | quote }}
*/}}
{{- define "common.logging.level" -}}
{{- $level := "INFO" -}}
{{- if .Values.global -}}
{{-   if .Values.global.logging -}}
{{-     if .Values.global.logging.level -}}
{{-       $level = .Values.global.logging.level -}}
{{-     end -}}
{{-   end -}}
{{- end -}}
{{- default $level .Values.logging.level -}}
{{- end -}}

{{/*
  Logging Flush Frequency
  @description: Frequency at which the log file is flushed at info or less level
  @author     : gildas@breizh.org
  @default    : none
  @values     :
    - duration   : either an ISO7601 or a duration string (e.g. 1s, 500ms, 2.5h, PT5M)
  @usage: You can configure this value at the global level or at the project level, for example:

    global:
      logging:
        flushFrequency: 1m

  or:

    logging:
      flushFrequency: PT5M

  Then, your Deployment template, just include this helper:

    containers:
      - name: my-container
        env:
          - name: LOG_FLUSHFREQUENCY
            value: {{ include "common.logging.flush-frequency" . | quote }}
*/}}
{{- define "common.logging.flush-frequency" -}}
{{- $flushFrequency := "" -}}
{{- if .Values.global -}}
{{-   if .Values.global.logging -}}
{{-     if .Values.global.logging.flushFrequency -}}
{{-       $flushFrequency = .Values.global.logging.flushFrequency -}}
{{-     end -}}
{{-   end -}}
{{- end -}}
{{- default $flushFrequency .Values.logging.flushFrequency -}}
{{- end -}}

{{/*
  Logging Source Information
  @description: Display source information (file, line, etc) in the logs if true
  @author     : gildas@breizh.org
  @default    : none
  @values     :
    - true or false
  @usage: You can configure this value at the global level or at the project level, for example:

    global:
      logging:
        sourceInfo: "true"

  or:

    logging:
      sourceInfo: "true"

  Then, your Deployment template, just include this helper:

    containers:
      - name: my-container
        env:
          - name: LOG_SOURCEINFO
            value: {{ include "common.logging.source-info" . | quote }}
*/}}
{{- define "common.logging.source-info" -}}
{{- $sourceInfo := "" -}}
{{- if .Values.global -}}
{{-   if .Values.global.logging -}}
{{-     if .Values.global.logging.sourceInfo -}}
{{-       $sourceInfo = .Values.global.logging.sourceInfo -}}
{{-     end -}}
{{-   end -}}
{{- end -}}
{{- default $sourceInfo .Values.logging.sourceInfo -}}
{{- end -}}

{{/*
  Logging Converter
  @description: Converter used to convert the log entry to other systems like Google StackDriver
  @author     : gildas@breizh.org
  @default    : none
  @values     :
    - "bunyan":      Write logs in the bunyan format
    - "cloudwatch":  Write logs in the cloudwatch format
    - "pino":        Write logs in the pino format
    - "stackdriver": Write logs in the Google StackDriver format
  @usage: You can configure this value at the global level or at the project level, for example:
    global:
      logging:
        converter: bunyan

  or:

    logging:
      converter: stackdriver

  Then, your Deployment template, just include this helper:

    containers:
      - name: my-container
        env:
          - name: LOG_CONVERTER
            value: {{ include "common.logging.converter" . | quote }}
*/}}
{{- define "common.logging.converter" -}}
{{- $converter := "" -}}
{{- if .Values.global -}}
{{-   if .Values.global.logging -}}
{{-     if .Values.global.logging.converter -}}
{{-       $converter = .Values.global.logging.converter -}}
{{-     end -}}
{{-   end -}}
{{- end -}}
{{- default $converter .Values.logging.converter -}}
{{- end -}}

{{/*
  Generate Logging Environment Variables
  @description: Generate the environment variables for the logging configuration.  
                If the flushFrequency is set to "immediate", the DEBUG environment variable is set to true
  @values: See the other logging templates for values
  @usage: Just include this helper in your Deployment template, under the containers.env section ()note the lack of "-" at the end of the include:
    containers:
      - name: my-container
        env:
          {{- include "common.logging.environment" . | nindent 12 }}
*/}}
{{- define "common.logging.environment" -}}
{{- $environment := list (dict "name" "LOG_LEVEL" "value" (include "common.logging.level" .)) -}}
{{- $flushFrequency := include "common.logging.flush-frequency" . -}}
{{- $environment = append $environment (dict "name" "LOG_FLUSHFREQUENCY" "value" $flushFrequency) -}}
{{- $sourceInfo := include "common.logging.source-info" . -}}
{{- if $sourceInfo -}}
{{-   $environment = append $environment (dict "name" "LOG_SOURCEINFO" "value" $sourceInfo) -}}
{{- end -}}
{{- $converter := include "common.logging.converter" . -}}
{{- if $converter -}}
{{-   $environment = append $environment (dict "name" "LOG_CONVERTER" "value" $converter) -}}
{{- end -}}
{{- $environment | toYaml | nindent 0 -}}
{{- end -}}
