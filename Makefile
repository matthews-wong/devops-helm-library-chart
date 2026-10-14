CHARTS := charts/lib-common charts/example-app
APP    := charts/example-app

.PHONY: validate
validate:
	helm dependency update $(APP)
	helm lint $(CHARTS)
	helm template demo $(APP) | kubeconform -strict -summary
	helm template demo $(APP) -f $(APP)/values-prod.yaml | kubeconform -strict -summary
