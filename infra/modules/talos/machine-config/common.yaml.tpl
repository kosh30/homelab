# yaml-language-server: $schema=https://raw.githubusercontent.com/siderolabs/talos/refs/heads/main/website/content/v1.10/schemas/config.schema.json
cluster:
  coreDNS:
    disabled: true
  apiServer:
    certSANs:
      - ${cluster_endpoint_ip}
      - ${cluster_endpoint_hostname}
  network:
    cni:
      name: none
    podSubnets:
      - 10.244.0.0/16
    serviceSubnets:
      - 10.96.0.0/12
  controllerManager:
    extraArgs:
      bind-address: 0.0.0.0
  proxy:
    disabled: true
  scheduler:
    extraArgs:
      bind-address: 0.0.0.0
    config:
      apiVersion: kubescheduler.config.k8s.io/v1
      kind: KubeSchedulerConfiguration
      profiles:
        - schedulerName: default-scheduler
          plugins:
            score:
              disabled:
                - name: ImageLocality
          pluginConfig:
            - name: PodTopologySpread
              args:
                defaultingType: List
                defaultConstraints:
                  - maxSkew: 1
                    topologyKey: kubernetes.io/hostname
                    whenUnsatisfiable: ScheduleAnyway
machine:
  kernel:
    modules:
      - name: zfs
  nodeLabels:
    topology.kubernetes.io/region: ${region}
    topology.kubernetes.io/zone: ${zone}
  kubelet:
#    clusterDNS:
#      - 169.254.2.53
#      - ${dns_server}
    nodeIP:
      validSubnets:
        - ${proxmox_subnet}
  network:
    hostname: ${name}
    interfaces:
      - interface: dummy0
        addresses:
          - 169.254.2.53/32
  install:
    wipe: true
  features:
    rbac: true
    stableHostname: true
    apidCheckExtKeyUsage: true
    hostDNS:
      enabled: true
