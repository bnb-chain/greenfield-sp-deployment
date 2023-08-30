## Pre-requisites for deployment
- MySql Database which is accessible from the k8s cluster where SP will be running in.
- S3 bucket created(equivalent object storage on other supported Cloud provider).
- DB connection url, DB shcema, bucket url are provided in SP's config file.
- AWS Secrets Manager store(equivalent Secret vault on other supported Cloud provider) for holding credentials, such as /dev/greenfield/gf-sp-devops/secrets
- IAM role with permission to S3 bucket and secret valut, and binding the role to the ServiceAccount used by SP pods.
- Put this as the content of the AWS Secrets Manager store with actual values:
```json
{
    "SP_DB_USER": "xxx",
    "SP_DB_PASSWORD": "xxx",
    "SIGNER_OPERATOR_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_FUNDING_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_APPROVAL_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_SEAL_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_GC_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_BLS_PRIV_KEY": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    }
```
NOTE: for production env, it's recommended to store the very sentive singer private keys in a seperate dedicated key vault that has very restricted access permission.