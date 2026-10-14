# devops-helm-library-chart

A small Helm library chart (`lib-common`) that holds the hardened defaults I
kept copy-pasting between charts: recommended labels, a restricted pod and
container `securityContext`, probes, resource limits, a Deployment and a
Service. A consumer chart (`example-app`) renders a full workload from about
ten lines of templates.

## Layout

```
charts/lib-common/   library chart (type: library, renders nothing on its own)
charts/example-app/  consumer chart that depends on lib-common via file://
```

## Usage

```bash
make validate
helm template demo charts/example-app -f charts/example-app/values-prod.yaml
```

## Requirements

- helm 3.12+ (tested with 4.3)
- kubeconform for schema validation
