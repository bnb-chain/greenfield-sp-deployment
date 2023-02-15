# Greenfield SP K8S

* Git URL: https://git.toolsfdg.net/nodereal/greenfield-sp-k8s
* TF URL (DEV and QA): https://git.toolsfdg.net/nodereal/terraform-nodereal-qa/tree/main/__modules/projects/greenfield/sp

## Requirements

* `kubectl` Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.6", GitCommit:"ff2c119726cc1f8926fb0585c74b25921e866a28", GitTreeState:"archive", BuildDate:"2023-02-06T17:45:37Z", GoVersion:"go1.20", Compiler:"gc", Platform:"darwin/arm64"}
* Kustomize Version: v4.5.7

## Environments

### DEV

* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal-dev
* AWS Account: nodereal-qa
* AWS Country: ap-northeast-1
* K8S cluster: tf-nodereal-dev-dev-ap
* Monitoring: <TBA>

### QA

* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal-qa
* AWS Account: nodereal-qa
* AWS Country: us-east-1
* K8S cluster: tf-nodereal-qa-qa-us
* Monitoring: https://monitor.infra.nodereal.cc/d/6aGk1hM4z/qa-sp?orgId=1

### Prod

* TF path: https://git.toolsfdg.net/nodereal/terraform-nodereal/...
* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal
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

      $ k -n gf-sp-a get pods
      $ k -n gf-sp-a exec -it gateway-bb945b478-8sfd4 bash
      gateway-bb945b478-8sfd4:/app$ ./test-gnfd-sp
      $ k -n gf-sp-a logs -f ${each_service_pod_name} // to check whether any error logs from other services



### For PROD env

- <TBA>


