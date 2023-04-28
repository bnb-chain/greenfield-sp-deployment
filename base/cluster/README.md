To deploy storage provider on demand in forms of all-in-one, samll, default, regular, large.

## Prerequisites for deployment
- MySql Database which is accessible from the k8s cluster where SP will be running in.
- storage_provider_db is created in MySql DB. (DB name is configurable in config.toml of gnfd-sp)
- block_syncer is created in Mysql DB. (can be in a different mysql to storage_provider_db one)
- S3 bucket created(equivalent object storage on other supported Cloud provider).
- AWS Secrets Manager store(equivalent Secret vault on other supported Cloud provider) for holding credentials, such as /dev/greenfield/gf-sp-devops/secrets
- IAM role with permission to S3 bucket and secret valut, and binding the role to the ServiceAccount used by SP pods.
- Put this as the content of the AWS Secrets Manager store with actual values:
```json
{
    "SP_DB_USER":"xxx",
    "SP_DB_PASSWORD":"xxx",
    "SP_DB_ADDRESS":"xxx:3306",
    "SP_DB_DATABASE":"storage_provider_db",
    "BLOCK_SYNCER_DSN":"xxx",
    "BLOCK_SYNCER_DB_USER":"xxx",
    "BLOCK_SYNCER_DB_PASSWORD":"xxx",
    "BS_DB_USER":"xxx",
    "BS_DB_PASSWORD":"xxx",
    "BS_DB_ADDRESS":"xxx:3306",
    "BS_DB_DATABASE":"block_syncer",
    "SIGNER_OPERATOR_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_FUNDING_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_APPROVAL_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SIGNER_SEAL_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "AWS_ACCESS_KEY":"xxx",
    "AWS_SECRET_KEY":"xxx",
    "BUCKET_URL":"xxx",
    "P2P_PRIVATE_KEY":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
```