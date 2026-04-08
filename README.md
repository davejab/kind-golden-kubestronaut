# Kind Golden Kubestronaut

Kind cluster with all golden kubestronaut apps installed. For educational purposes only. Work in progress.

## Pre-requisites

- kind
- cloud-provider-kind
- go
- helm

## Quick start

```sh
# run kind cluster and cloud kind provider
./run.sh
# install all apps
./install.sh -wq
# install specific app
./install.sh -wqa cilium
# print available ingress
./ingress.sh
# teardown kind cluster
./teardown.sh
```

## Apps

| App  |  Chart |  Version | Docs |
|---|---|---|---|
| Cilium | [chart](https://github.com/cilium/cilium/tree/main/install/kubernetes/cilium) | 1.19.1 | [docs](https://docs.cilium.io/en/stable/) |
| Prometheus | [chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) | 82.10.0 | [docs](https://prometheus.io/docs/introduction/overview/), [operator](https://prometheus-operator.dev/docs/getting-started/introduction/) |
| Grafana | [chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) | 82.10.0 | [docs](https://grafana.com/docs/grafana/latest/) |
| Loki | [chart](https://github.com/grafana-community/helm-charts/tree/main/charts/loki) | 6.55.0 | [docs](https://grafana.com/docs/loki/latest/) |
| OpenTelemetry Collector | [chart](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-collector) | 0.147.1 | [docs](https://opentelemetry.io/docs/platforms/kubernetes/helm/collector/) |
| Jaeger | [chart](https://github.com/jaegertracing/helm-charts/tree/main/charts/jaeger) | 4.6.0 | [docs](https://www.jaegertracing.io/docs/) |
| Alert Manager | [chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) | 82.10.0 | [docs](https://prometheus.io/docs/alerting/latest/alertmanager/) |
| Metrics Server | [chart](https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server) | 3.13.0 | [docs](https://github.com/kubernetes-sigs/metrics-server) |
| Cert Manager | [chart](https://github.com/cert-manager/cert-manager/tree/master/deploy/charts/cert-manager) | v1.20.0 | [docs](https://cert-manager.io/docs/) |
| Kyverno | [chart](https://github.com/kyverno/kyverno/tree/main/charts/kyverno) | 3.7.1 | [docs](https://kyverno.io/docs/introduction/) |
| Kyverno Policies | [chart](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) | 3.7.1 | |
| Istio | [charts](https://github.com/istio/istio/tree/master/manifests/charts) | 1.29.0 | [docs](https://istio.io/latest/docs/) |
| Kiali | [chart](https://github.com/kiali/helm-charts/tree/master/kiali-operator) | 2.22.0 | [docs](https://kiali.io/docs/) |
| ArgoCD | [chart](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd) | 9.4.7 | [docs](https://argo-cd.readthedocs.io/en/stable/) |
| Backstage | [chart](https://github.com/backstage/charts/tree/main/charts/backstage) | 2.6.3 | [docs](https://backstage.io/docs/overview/generated-index) |