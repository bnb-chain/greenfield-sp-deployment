Greenfield Storage Provider Deployment Guide
============================================

Supported Cloud Providers
-------------------------
We currently support only deployment to AWS (EKS). Other cloud providers (e.g. Alicloud, GCP)
are in our pipeline and will be supported in the future.


Quick Start
-----------

For detail about what "storage provider" is, please see
https://greenfield.bnbchain.org/docs/guide/storage-provider/.


Pre-requisites:
1. AWS account
2. AWS EKS available
3. Kustomize client
4. For monitoring:
   a. Victoria Metrics
   b. Grafana dashboard

Steps:
1. Create AWS resources
   a. Application IAM service account
   b. RDS
   c. S3 bucket
   d. Secret manager
   e. ACM Certificate
   f. Route53
2. Create first SP cluster
   a. K8S "Application" resource
   b. K8S overlay config and patches
   c. SP application config file (i.e. `.toml` file)
   d. Simple verification
3. Create other SP clusters
   a. P2P connections configuation
4. Set up monitoring dashboard
   a. Configure victoria metrics collection
   b. Set up dashboard
   c. Configure alert channels (e.g. Slack)

