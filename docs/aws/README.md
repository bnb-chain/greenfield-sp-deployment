AWS Resources
=============

IAM role
--------

* Create a new role which will be used by SP K8S application.
![1](imgs/iam-k8s-role.png "IAM Role")

* Add S3 permission policy - This is where SP stores its user uploaded content.
![2](imgs/iam-k8s-role-s3.png "IAM Role S3")

* Add Secret Manager permission policy - K8S will retrieve secret from here as app parameters
![3](imgs/iam-k8s-role-sm.png "IAM Role Secret Manager")

* Bind K8S service account to this IAM role
![4](imgs/iam-k8s-role-trust-relationship.png "IAM Role Trust Relationship")


Database (RDS)
--------------

* Create RDS database and jot down the connection string, username and password.
![5](imgs/rds.png)


S3 Bucket
---------

* Create S3 bucket
![6](imgs/rds.png)


Secret Manager
--------------

* Create secret and update secret value (example provided below)
![7](imgs/secret-manager.png)

* Update secret value
```json
{
    "SP_DB_USER":"xxx",
    "SP_DB_PASSWORD":"xxx",
    "SP_DB_ADDRESS":"xxx:3306",
    "SP_DB_DATABASE":"xxx",
    "BLOCK_SYNCER_DSN":"xxx",
    "BLOCK_SYNCER_DB_USER":"xxx",
    "BLOCK_SYNCER_DB_PASSWORD":"xxx",
    "BS_DB_USER":"xxx",
    "BS_DB_PASSWORD":"xxx",
    "BS_DB_ADDRESS":"xxx:3306",
    "BS_DB_DATABASE":"block_syncer",
    "SIGNER_OPERATOR_PRIV_KEY":"",
    "SIGNER_FUNDING_PRIV_KEY":"",
    "SIGNER_APPROVAL_PRIV_KEY":"",
    "SIGNER_SEAL_PRIV_KEY":"",
    "AWS_ACCESS_KEY":"xxx",
    "AWS_SECRET_KEY":"xxx",
    "BUCKET_URL":"xxx",
    "P2P_PRIVATE_KEY":""
    }
``` 

