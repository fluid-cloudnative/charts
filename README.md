# Fluid charts

Helm charts for fluid

Add Fluid repository to Helm repos:

```bash
helm repo add fluid https://fluid-cloudnative.github.io/charts
```

Update to get the latest information about charts from `fluid` repositories.

```bash
helm repo update
```

## Stable version

Search available version:

```bash
helm search repo fluid
```

Install available version:

```bash
helm install fluid fluid/fluid
```

## Develop version

Search develop version:

```bash
helm search repo fluid --devel
```

Install develop version:

```bash
helm install fluid fluid/fluid --devel
```
