This base will deploy storage provider in cluster mode - one pod for each service.

## Prerequisites for deployment
- MySql Database which is accessible from the k8s cluster where SP will be running in.
- storage_provider_db is created in MySql DB.
- block_syncer is created in Mysql DB. (can be in a different mysql to storage_provider_db one)
- S3 bucket created.
- Access Key and Secret Key of IAM user with permission to S3 bucket.
- AWS Secrets Manager store for holding credentials, such as /dev/greenfield/gf-sp-devops/secrets
- Put this as the content of the AWS Secrets Manager store with actual values:
```json
{"SP_DB_USER":"xxx","SP_DB_PASSWORD":"xxx","SP_DB_ADDRESS":"xxx:3306","SP_DB_DATABASE":"storage_provider_db","BLOCK_SYNCER_DSN":"xxx","BLOCK_SYNCER_DB_USER":"xxx","BLOCK_SYNCER_DB_PASSWORD":"xxx","BS_DB_USER":"xxx","BS_DB_PASSWORD":"xxx","BS_DB_ADDRESS":"xxx:3306","BS_DB_DATABASE":"block_syncer","SIGNER_OPERATOR_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","SIGNER_FUNDING_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","SIGNER_APPROVAL_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","SIGNER_SEAL_PRIV_KEY":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","AWS_ACCESS_KEY":"xxx","AWS_SECRET_KEY":"xxx","BUCKET_URL":"xxx"}
```