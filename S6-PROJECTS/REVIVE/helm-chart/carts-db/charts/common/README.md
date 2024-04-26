# common-charts
Helm toolbox providing common chart templates

## Installation

In your Chart.yaml, just add the following dependencies:

```yaml
dependencies:
  ...
  - name: common
    repository: https://gildas.github.io/charts
    version: ~1.0.0
```

Then enjoy the template definitions in your own templates!

## Usage

For example, adding the usual names, labels, and selectors to a Deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    {{- include "common.labels" | nindent 4 }}
spec:
  selector:
    matchLabels:
      {{- include "common.selectorLabels" | nindent 6 }}
    template:
      metadata:
         ...
         labels:
           {{- include "common.selectorLabels" | nindent 8 }}
      spec:
        ...
        serviceAccountName: {{ include "common.names.serviceaccount" . }}
        containers:
          - ...
            image: {{ include "common.names.image" . | quote }}
            ...
            env:
              {{- include "common.logging.environment" . | nindent 12 }}
              - name:  MYVAR
                value: "myvalue"
```

## Configuration

Many template macro will be configuration via the `values.yaml` file of your chart. When using umbrella charts, some macros will allow global overriding of their configuration. The global provided values will override the local values of each sub-chart.

Here is a list of these macros:

- `common.names.image`  
  Global value: `imageRegistry`, will contain the registry to pull all images from
- `common.logging.level`  
  Global value: `logging.level`, will set the log of all programs using gildas/go-logger  
  This macro is used by the general macro `common.logging.environment`
- `common.logging.flush-frequency`  
  Global value: `logging.flushFrenquency`, will set the flush frequency of all programs using gildas/go-logger  
  This macro is used by the general macro `common.logging.environment`
- `common.logging.source-info`  
  Global value: `logging.sourceInfo`, will set the file source logging of all programs usung gildas/go-logger  
  This macro is used by the general macro `common.logging.environment`
- `common.logging.converter`  
  Global value: `logging.converter, will set the log converter of all programs usung gildas/go-logger  
  This macro is used by the general macro `common.logging.environment`
