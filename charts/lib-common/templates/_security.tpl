{{- define "lib-common.podSecurityContext" -}}
runAsNonRoot: true
runAsUser: {{ .Values.runAsUser | default 10001 }}
runAsGroup: {{ .Values.runAsUser | default 10001 }}
fsGroup: {{ .Values.runAsUser | default 10001 }}
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{- define "lib-common.containerSecurityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
{{- end -}}
