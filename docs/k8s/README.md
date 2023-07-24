# Create a SP cluster

Pre-requisite is that AWS resources must first be created. Please see aws section for details.

Then, using `kustomize`, you can create the app in K8S (EKS) very quickly.


## Cluster Size Selection
We currently support a number of cluster modes, depending on the requirements of performance.
1. all-in-one: All services of SP are deployed in a single pod.
2. regular: An arrangement where some services will be combined as a pod.
3. large: Each service is a pod by itself.

## Setting up K8S via kustomize

To set up a primary SP cluster, using `kustomize` we can deploy it with the following YAML. You can
replace the `value`s in the YAML file.

```
resources:
  - https://github.com/bnb-chain/greenfield-storage-provider/deployment/kustomize/base/vendors/aws/large?ref=develop


images:
- name: ghcr.io/bnb-chain/greenfield-storage-provider
  newTag: 0.2.3-alpha.2

configMapGenerator:
- name: config
  files:
  - configs/config.toml

patches:
- target:
    kind: Service
    name: p2p-external
  patch: |-
    - op: replace
      path: /metadata/annotations/service.beta.kubernetes.io~1aws-load-balancer-subnets
      value: subnet-a,subnet-b,subnet-c
- target:
    kind: Ingress
    name: gateway
  patch: |-
    - op: replace
      path: /spec/rules/0/host
      value: sp-a.yourdomain.com
    - op: replace
      path: /spec/rules/1/host
      value: *.sp-a.yourdomain.com
- target:
    kind: ServiceAccount
    name: nodereal-default
  patch: |-
    - op: replace
      path: /metadata/annotations/eks.amazonaws.com~1role-arn
      value: arn:aws:iam::111111111111:role/greenfield-sp-a
- target:
    kind: SecretStore
    name: default
  patch: |-
    - op: replace
      path: /spec/provider/aws/region
      value: ap-northeast-1
- target:
    kind: ExternalSecret
    name: default
  patch: |-
    - op: replace
      path: /spec/dataFrom/0/extract/key
      value: /projects/greenfield/sp/a
- target:
    kind: ServiceMonitor
    name: default
  patch: |-
    - op: replace
      path: /spec/namespaceSelector/matchNames/0
      value: gf-sp-a
```

### Config file

Here is the config file used in the above `configMapGenerator`. You will need to obtain and
replace `SpOperatorAddress`, `ChainID`, `GreenfieldAddresses` and `TendermintAddresses` from your env.

```
# services list are to be started
Server = []
GRPCAddress = '0.0.0.0:9333'

[SpDB]
User = ''
Passwd = ''
Address = ''
Database = 'storage_provider_db'

[BsDB]
User = ''
Passwd = ''
Address = ''
Database = 'block_syncer'

[BsDBBackup]
User = ''
Passwd = ''
Address = ''
Database = 'block_syncer_backup'

[PieceStore]
Shards = 0

[PieceStore.Store]
Storage = 's3'
# BucketURL = ''
MaxRetries = 5
MinRetryDelay = 0
TLSInsecureSkipVerify = false
IAMType = 'SA'

[Chain]
ChainID = 'REPLACE_ME'
ChainAddress = ['https://gnfd.qa.bnbchain.world:443']

[SpAccount]
SpOperatorAddress = 'REPLACE_ME'
# OperatorPrivateKey = ''
# FundingPrivateKey = ''
# SealPrivateKey = ''
# ApprovalPrivateKey = ''
# GcPrivateKey = ''

[Endpoint]
ApproverEndpoint = 'approver:9333'
ManagerEndpoint = 'manager:9333'
DownloaderEndpoint = 'downloader:9333'
ReceiverEndpoint = 'receiver:9333'
MetadataEndpoint = 'metadata:9333'
UploaderEndpoint = 'uploader:9333'
P2PEndpoint = 'p2p:9333'
SignerEndpoint = 'signer:9333'
AuthenticatorEndpoint = 'localhost:9333'

[Gateway]
DomainName = 'replace-me.domain.com'
HTTPAddress = '0.0.0.0:9033'

[P2P]
#P2PPrivateKey = ''
P2PAddress = '0.0.0.0:9933'
P2PAntAddress = ''
P2PBootstrap = ['']
# P2PPingPeriod = 0

[Parallel]
DiscontinueBucketEnabled = false
DiscontinueBucketKeepAliveDays = 2
UploadObjectParallelPerNode = 10240
ReceivePieceParallelPerNode = 10240
DownloadObjectParallelPerNode = 10240
ChallengePieceParallelPerNode = 10240
AskReplicateApprovalParallelPerNode = 10240
GlobalCreateBucketApprovalParallel = 10240
GlobalCreateObjectApprovalParallel = 10240
GlobalMaxUploadingParallel = 10240
GlobalUploadObjectParallel = 10240
GlobalReplicatePieceParallel = 10240
GlobalSealObjectParallel = 10240
GlobalReceiveObjectParallel = 10240

[Monitor]
DisableMetrics = false
DisablePProf = false
MetricsHTTPAddress = '0.0.0.0:24367'
PProfHTTPAddress = '0.0.0.0:24368'

[Rcmgr]
DisableRcmgr = false

[Metadata]
IsMasterDB = true
BsDBSwitchCheckIntervalSec = 30

[BlockSyncer]
Modules = ['epoch','bucket','object','payment','group','permission','storage_provider','prefix_tree', 'virtual_group','sp_exit_events','object_id_map']
Dsn = ""
DsnSwitched = ''
Workers = 50
EnableDualDB = false

[APIRateLimiter]
PathPattern = [{Key = ".*request_nonc.*", RateLimit = 10, RatePeriod = 'S'},{Key = ".*1l65v.*", RateLimit = 20, RatePeriod = 'S'}]
HostPattern = [{Key = ".*vfdxy.*", RateLimit = 15, RatePeriod = 'S'}]
[APIRateLimiter.IPLimitCfg]
On = true
RateLimit = 5000
RatePeriod = 'S'

[Manager]
EnableLoadTask = true
```


## Setting up secret

The SP app also will fetch secret from AWS (used as external secret in K8S). Please see AWS
doc for creating the secret. The secret JSON content will be like the followings:

```json
{
    "SP_DB_USER": "greenfield",
    "SP_DB_PASSWORD": "pwd",
    "SP_DB_ADDRESS": "rm-0ixxxxx.mysql.japan.rds.company.com",
    "SP_DB_DATABASE": "storage_provider_db",
    "BLOCK_SYNCER_DSN": "greenfield:pwd@tcp(rm-0ixxxxx.mysql.japan.rds.company.com)/block_syncer?parseTime=true&multiStatements=true&loc=Local",
    "BLOCK_SYNCER_DB_USER": "greenfield",
    "BLOCK_SYNCER_DB_PASSWORD": "pwd",
    "BS_DB_USER": "greenfield",
    "BS_DB_PASSWORD": "pwd",
    "BS_DB_ADDRESS": "rm-0ixxxxx.mysql.japan.rds.company.com",
    "BS_DB_DATABASE": "block_syncer",
    "SIGNER_OPERATOR_PRIV_KEY": "",
    "SIGNER_FUNDING_PRIV_KEY": "",
    "SIGNER_APPROVAL_PRIV_KEY": "",
    "SIGNER_SEAL_PRIV_KEY": "",
    "SIGNER_BLS_PRIV_KEY": "",
    "SIGNER_GC_PRIV_KEY": "",
    "AWS_ACCESS_KEY": "",
    "AWS_SECRET_KEY": "",
    "BUCKET_URL": "https://oss-ap-northeast-1.company.com/tf-nodereal-dev-greenfield-devnet-sp-a",
    "P2P_PRIVATE_KEY": "",
    "BLOCK_SYNCER_DSN_SWITCHED": "greenfield:pwd@tcp(rm-0ixxxxx.mysql.japan.rds.company.com)/block_syncer_backup?parseTime=true&multiStatements=true&loc=Local",
    "BS_DB_SWITCHED_ADDRESS": "rm-0ixxxxx.mysql.japan.rds.company.com",
    "BS_DB_SWITCHED_DATABASE": "block_syncer_backup",
    "BS_DB_SWITCHED_PASSWORD": "pwd",
    "BS_DB_SWITCHED_USER": "greenfield"
}
```

refer to [runbook](https://github.com/bnb-chain/greenfield-docs/blob/718b662489fd862f56c1a0b9748f357b71735bd0/src/guide/storage-provider/run-book/run-testnet-SP-node.md) to check how to get the keys.

build command: `kustomize build . > sp.yaml`
apply command: `kubectl apply -f ./sp.yaml`

