# Greenfield SP K8S

* Git URL: https://git.toolsfdg.net/nodereal/greenfield-sp-k8s


## Environments

### DEV

* TF repo path: https://git.toolsfdg.net/nodereal/terraform-nodereal-qa
* AWS Account: nodereal-qa
* AWS Country: ap-northeast-1
* K8S cluster: tf-nodereal-dev-dev-ap
* Monitoring: <TBA>

### QA

* TF repo path: https://git.toolsfdg.net/nodereal/terraform-nodereal-qa
* AWS Account: nodereal-qa
* AWS Country: us-east-1
* K8S cluster: tf-nodereal-qa-qa-us
* Monitoring: https://monitor.infra.nodereal.cc/d/6aGk1hM4z/qa-sp?orgId=1

### Prod

* TF repo path: https://git.toolsfdg.net/nodereal/terraform-nodereal
* K8S cluster: tf-nodereal-prod-noderealus
* AWS Account: nodereal
* AWS Country: us-east-1
* Monitoring: <TBA>


## How to deploy?

### For DEV / QA env

- Apply the Terraform changes first

- To generate using `kustomize`:

    $ kustomize build overlays/{env}

- To apply it:

    $ tsh login --proxy=tele-nodereal-qa.iac.toolsfdg.net:8024 --auth=okta
    $ tsh kube login tf-nodereal-dev-dev-ap
    $ # For QA: tsh kube login tf-nodereal-qa-qa-us
    $ kustomize build overlays/{env} > {env}.yaml
    $ kustomize apply -f ./{env}.yaml

- To verify deployment:

    $ <TODO>


### For PROD env

- <TBA>

