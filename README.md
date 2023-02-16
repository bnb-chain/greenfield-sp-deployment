# Greenfield SP K8S

* Git URL: https://git.toolsfdg.net/nodereal/greenfield-sp-k8s
* TF URL (DEV and QA): https://git.toolsfdg.net/nodereal/terraform-nodereal-qa/tree/main/\__modules/projects/greenfield/sp

## Requirements

* `kubectl` Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.6", GitCommit:"ff2c119726cc1f8926fb0585c74b25921e866a28", GitTreeState:"archive", BuildDate:"2023-02-06T17:45:37Z", GoVersion:"go1.20", Compiler:"gc", Platform:"darwin/arm64"}
* Kustomize Version: v4.5.7

## Environments

### DEV

* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal-dev
* AWS Account: nodereal-qa
* AWS Country: ap-northeast-1
* K8S cluster: tf-nodereal-dev-dev-ap
* Teleport cluster: tele-nodereal-qa.iac.toolsfdg.net:8024
* Monitoring: {TBA}

### QA

* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal-qa
* AWS Account: nodereal-qa
* AWS Country: us-east-1
* K8S cluster: tf-nodereal-qa-qa-us
* Teleport cluster: teleport.nodereal.link
* Monitoring: https://monitor.infra.nodereal.cc/d/6aGk1hM4z/qa-sp?orgId=1

### Prod

* TF workspace: https://tfe.toolsfdg.net/app/nodereal/workspaces/nodereal
* TF path: https://git.toolsfdg.net/nodereal/terraform-nodereal
* K8S cluster: tf-nodereal-prod-noderealus
* Teleport cluster: teleport.nodereal.link
* AWS Account: nodereal
* AWS Country: us-east-1
* Monitoring: {TBA}


## How to deploy?

### For DEV / QA env

- Apply the Terraform changes first

- To generate using `kustomize`:

      $ kustomize build overlays/{env}

- To apply it:

      $ tsh login --proxy={teleport-cluster} --auth=okta
      $ tsh kube login {k8s-cluster}
      $ kustomize build overlays/{env} > {env}.yaml
      $ kustomize apply -f ./{env}.yaml

- To verify deployment:

  * Run test tool:

        $ kubectl -n {namespace} exec -it pod/{gateway-pod} -- ./test-gnfd-sp

  * See logs:

        $ kubectl -n {namespace} get pods
        $ kubectl -n {namespace} logs -f ${each_service_pod_name} // to check whether any error logs from other services

  * Check publicly exposed URL:

        $ # TODO: what is the command to check the gateway service running with "curl" please?

  * Confirm changes with rosy.r@nodereal.io / will.w@nodereal.io / joey@nodereal.io / dylan.y@nodereal.io / richard@nodereal.io

### For PROD env

- TODO:

