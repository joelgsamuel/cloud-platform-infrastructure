
prometheus:
  ## Alertmanagers to which alerts will be sent
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#alertmanagerendpoints
  ##
  alertingEndpoints: []
  #   - name: ""
  #     namespace: ""
  #     port: 9093
  #     scheme: http

  ## Prometheus configuration directives
  ## Ignored if serviceMonitors are defined
  ## Ref: https://prometheus.io/docs/operating/configuration/
  ##
  config:
    specifiedInValues: true
    value: {}

  ## External URL at which Prometheus will be reachable
  ##
  externalUrl: "${promtheus_ingress}"

  ## Prometheus container image
  ##
  image:
    repository: quay.io/prometheus/prometheus
    tag: v2.6.0

  ingress:
    ## If true, Prometheus Ingress will be created
    ##
    enabled: false

    ## Annotations for Prometheus Ingress
    ##
    annotations: {}
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"

    ## Labels to be added to the Ingress
    ##
    labels: {}

    ## Hostnames.
    ## Must be provided if Ingress is enabled.
    ##
    # hosts:
    #   - alertmanager.domain.com
    hosts: []

    ## TLS configuration for Prometheus Ingress
    ## Secret must be manually created in the namespace
    ##
    tls: []
      # - secretName: prometheus-k8s-tls
      #   hosts:
      #     - prometheus.example.com

  ## Node labels for Prometheus pod assignment
  ## Ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}

  ## If true, the Operator won't process any Prometheus configuration changes
  ##
  paused: false

  ## Number of Prometheus replicas desired
  ##
  replicaCount: 1

  ## Pod anti-affinity can prevent the scheduler from placing Prometheus replicas on the same node.
  ## The default value "soft" means that the scheduler should *prefer* to not schedule two replica pods onto the same node but no guarantee is provided.
  ## The value "hard" means that the scheduler is *required* to not schedule two replica pods onto the same node.
  ## The value "" will disable pod anti-affinity so that no anti-affinity rules will be configured.
  podAntiAffinity: "soft"

  ## Resource limits & requests
  ## Ref: https://kubernetes.io/docs/user-guide/compute-resources/
  ##
  resources:
    requests:
      cpu: 1
      memory: 4000Mi
    limits:
      cpu: 1
      memory: 4000Mi

  ## List of Secrets in the same namespace as the Prometheus
  ## object, which shall be mounted into the Prometheus Pods.
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec
  ##
  secrets: []

  ## How long to retain metrics
  ##
  retention: 30d

  ## Prefix used to register routes, overriding externalUrl route.
  ## Useful for proxies that rewrite URLs.
  ##
  routePrefix: /

  ## Rules configmap selector
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/design.md
  ##
  ## 1. If `matchLabels` is used, `rules.additionalLabels` must contain all the labels from
  ##    `matchLabels` in order to be be matched by Prometheus
  ## 2. If `matchExpressions` is used `rules.additionalLabels` must contain at least one label
  ##    from `matchExpressions` in order to be matched by Prometheus
  ## Ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
  rulesSelector:
    any: true

  ruleNamespaceSelector:
    any: true

   # rulesSelector: {
   #   matchExpressions: [{key: prometheus, operator: In, values: [example-rules, example-rules-2]}]
   # }
   ### OR
   # rulesSelector: {
   #   matchLabels: [{role: example-rules}]
   # }

  ## Prometheus alerting & recording rules
  ## Ref: https://prometheus.io/docs/querying/rules/
  ## Ref: https://prometheus.io/docs/alerting/rules/
  ##
  rules:
    specifiedInValues: true
    ## What additional rules to be added to the ConfigMap
    ## You can use this together with `rulesSelector`
    additionalLabels: {}
    #  prometheus: example-rules
    #  application: etcd
    value: {}

  service:
    ## Annotations to be added to the Service
    ##
    annotations: {}

    ## Cluster-internal IP address for Prometheus Service
    ##
    clusterIP: ""

    ## List of external IP addresses at which the Prometheus Service will be available
    ##
    externalIPs: []

    ## External IP address to assign to Prometheus Service
    ## Only used if service.type is 'LoadBalancer' and supported by cloud provider
    ##
    loadBalancerIP: ""

    ## List of client IPs allowed to access Prometheus Service
    ## Only used if service.type is 'LoadBalancer' and supported by cloud provider
    ##
    loadBalancerSourceRanges: []

    ## Port to expose on each node
    ## Only used if service.type is 'NodePort'
    ##
    nodePort: 30900

    ## Service type
    ##
    type: ClusterIP

  ## Service monitors selector
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/design.md
  ##
  serviceMonitorsSelector:
    any: true

  serviceMonitorNamespaceSelector:
    any: true

  ## ServiceMonitor CRDs to create & be scraped by the Prometheus instance.
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/service-monitor.md
  ##
  serviceMonitors: []
    ## Name of the ServiceMonitor to create
    ##
    # - name: ""

      ## Service label for use in assembling a job name of the form <label value>-<port>
      ## If no label is specified, the service name is used.
      ##
      # jobLabel: ""

      ## Label selector for services to which this ServiceMonitor applies
      ##
      # selector: {}

      ## Namespaces from which services are selected
      ##
      # namespaceSelector:
        ## Match any namespace
        ##
        # any: false

        ## Explicit list of namespace names to select
        ##
        # matchNames: []

      ## Endpoints of the selected service to be monitored
      ##
      # endpoints: []
        ## Name of the endpoint's service port
        ## Mutually exclusive with targetPort
        # - port: ""

        ## Name or number of the endpoint's target port
        ## Mutually exclusive with port
        # - targetPort: ""

        ## File containing bearer token to be used when scraping targets
        ##
        #   bearerTokenFile: ""

        ## Interval at which metrics should be scraped
        ##
        #   interval: 30s

        ## HTTP path to scrape for metrics
        ##
        #   path: /metrics

        ## HTTP scheme to use for scraping
        ##
        #   scheme: http

        ## TLS configuration to use when scraping the endpoint
        ##
        #   tlsConfig:

            ## Path to the CA file
            ##
            # caFile: ""

            ## Path to client certificate file
            ##
            # certFile: ""

            ## Skip certificate verification
            ##
            # insecureSkipVerify: false

            ## Path to client key file
            ##
            # keyFile: ""

            ## Server name used to verify host name
            ##
            # serverName: ""

  ## Prometheus StorageSpec for persistent data
  ## Ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/user-guides/storage.md
  ##
  storageSpec:
    volumeClaimTemplate:
      spec:
        storageClassName: prometheus-storage
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 100Gi
      selector: {}


# default rules are in templates/general.rules.yaml
prometheusRules: {}

# Select Deployed DNS Solution
deployCoreDNS: false
deployKubeDNS: true
deployKubeEtcd: true
