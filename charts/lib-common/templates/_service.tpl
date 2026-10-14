{{- define "lib-common.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "lib-common.fullname" . }}
  labels:
    {{- include "lib-common.labels" . | nindent 4 }}
spec:
  type: ClusterIP
  ports:
    - name: http
      port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
  selector:
    {{- include "lib-common.selectorLabels" . | nindent 4 }}
{{- end -}}
