# Kind Golden Kubestronaut

Kind cluster with all golden kubestronaut apps installed. For educational purposes only.

## Pre-requisites

- kind
- cloud-provider-kind
- go

## Quick start

```sh
# run kind cluster and cloud kind provider
./run.sh
# install all apps
./install.sh -wq
# install specific app
./install.sh -wqa cilium
# teardown kind cluster
./teardown.sh
```

## Apps

- [Cilium](https://cilium.io/) - [chart](https://github.com/cilium/cilium/tree/main/install/kubernetes/cilium)
- Prometheus Stack - [chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
    - [Prometheus](https://prometheus.io/docs/introduction/overview/)
    - [Grafana](https://grafana.com/docs/grafana/latest/)
    - [Prometheus Operator](https://prometheus-operator.dev/docs/getting-started/introduction/)
- [metrics-server](https://github.com/kubernetes-sigs/metrics-server) - [chart](https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server)
- [Kyverno](https://kyverno.io/) - [chart](https://github.com/kyverno/kyverno/tree/main/charts/kyverno)
    - [Policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies)