{{- define "lib-common.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "lib-common.fullname" . }}
  labels:
    {{- include "lib-common.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "lib-common.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "lib-common.labels" . | nindent 8 }}
    spec:
      automountServiceAccountToken: false
      securityContext:
        {{- include "lib-common.podSecurityContext" . | nindent 8 }}
      containers:
        - name: {{ include "lib-common.name" . }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: {{ .Values.containerPort }}
              protocol: TCP
          securityContext:
            {{- include "lib-common.containerSecurityContext" . | nindent 12 }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          startupProbe:
            httpGet:
              path: {{ .Values.probes.path }}
              port: http
            failureThreshold: 30
            periodSeconds: 2
          livenessProbe:
            httpGet:
              path: {{ .Values.probes.path }}
              port: http
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: {{ .Values.probes.path }}
              port: http
            periodSeconds: 5
          volumeMounts:
            - name: tmp
              mountPath: /tmp
      volumes:
        - name: tmp
          emptyDir: {}
{{- end -}}
