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

## Design notes

- Library templates are `define` blocks only; the consumer decides what to
  render, so a chart can use the Deployment helper and bring its own Service.
- Consumers must supply `image`, `resources`, `probes.path` and `containerPort`.
  The consumer's `values.schema.json` rejects the `latest` tag and missing
  resource requests/limits at `helm lint` and `helm template` time.
- The root filesystem is read-only; `/tmp` is an `emptyDir`.
- `Chart.lock` is not committed because the only dependency is a local path.

## Validation

`make validate` lints both charts and checks the rendered default and prod
manifests with kubeconform (`-strict`). CI runs the same target.
