Greenfield SP K8S
=================

This is the base K8S resources repo for storage provider at
https://github.com/node-real/greenfield-sp-k8s.git.


Directory structure
-------------------

    .
    ├── CODEOWNERS
    ├── README.md
    ├── base
    │   ├── cluster
    │   │   ├── README.md
    │   │   ├── small
    │   │   ├── large
    │   │   ├── regular
    │   ├── components
    │   │   ├── README.md
    │   │   ├── combo
    │   │   ├── job
    │   │   ├── network
    │   │   ├── shared
    │   │   └── single
    │   └── null
    │       ├── kustomization.yaml
    │       ├── namespace.yaml
    │       └── pod.yaml
    ├── docs
    │   ├── README.md
    │   ├── aws
    │   ├── grafana
    │   │   ├── README.md
    │   │   ├── dashboards
    │   │   └── imgs
    │   └── k8s
    └── scripts
        └── internal_service_connection.sh

* `base/`: Base kustomize manifest root folder
* `base/cluster`: Provide different kind of clusters (based on amount of resources)
* `base/components`: Provide smaller components that are used to create a functional cluster above
* `base/null`: Empty deployment for testing purpose
* `docs/`: Provide specific deployment documentations classified by infrastructure
* `scripts/`: Provide useful scripts to interact with app deployed in K8S

Please see `docs/README.md` for detail deployment guide.

