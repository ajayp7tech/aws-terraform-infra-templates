# AWS Terraform Infrastructure Templates

<p align="left">
  <img src="https://img.shields.io/badge/Terraform-844FBA?style=flat-square&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white"/>
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square"/>
</p>

A library of production-ready, reusable Terraform modules for provisioning AWS infrastructure. Built to reduce environment setup time, eliminate manual configuration drift, and ensure consistent deployments across dev, staging, and production.

Covers the most common AWS infrastructure patterns for Java microservices: EKS clusters, RDS Aurora, ElastiCache Redis, API Gateway, VPC networking, IAM, and CI/CD pipelines.

---

## 📐 Infrastructure overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                          AWS Account                                 │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                     VPC (10.0.0.0/16)                        │   │
│  │                                                              │   │
│  │  ┌─────────────────┐         ┌─────────────────┐            │   │
│  │  │  Public Subnets │         │ Private Subnets  │            │   │
│  │  │                 │         │                  │            │   │
│  │  │  ┌───────────┐  │         │  ┌────────────┐  │            │   │
│  │  │  │    ALB    │  │         │  │  EKS Node  │  │            │   │
│  │  │  │(Port 443) │  │────────▶│  │   Group    │  │            │   │
│  │  │  └───────────┘  │         │  └────────────┘  │            │   │
│  │  │  ┌───────────┐  │         │  ┌────────────┐  │            │   │
│  │  │  │  NAT GW   │  │         │  │RDS Aurora  │  │            │   │
│  │  │  └───────────┘  │         │  │(PostgreSQL)│  │            │   │
│  │  └─────────────────┘         │  └────────────┘  │            │   │
│  │                              │  ┌────────────┐  │            │   │
│  │                              │  │ElastiCache │  │            │   │
│  │                              │  │  (Redis)   │  │            │   │
│  │                              │  └────────────┘  │            │   │
│  │                              └─────────────────┘            │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │
│  │  API Gateway │  │   Route 53   │  │  CloudWatch  │              │
│  │   + Lambda   │  │  (DNS + SSL) │  │  + Alarms    │              │
│  └──────────────┘  └──────────────┘  └──────────────┘              │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 📦 Available modules

| Module | Description | Key resources |
|---|---|---|
| [`vpc`](./modules/vpc) | VPC with public/private subnets across 3 AZs, NAT gateway, route tables | VPC, Subnets, IGW, NAT GW, Route Tables |
| [`eks`](./modules/eks) | EKS cluster with managed node groups, IRSA, and cluster autoscaler | EKS Cluster, Node Groups, IAM Roles |
| [`rds-aurora`](./modules/rds-aurora) | Aurora PostgreSQL cluster with Multi-AZ, automated backups, encryption | Aurora Cluster, Parameter Groups, Subnet Groups |
| [`elasticache`](./modules/elasticache) | Redis cluster with Multi-AZ, automatic failover, encryption at rest | ElastiCache Cluster, Subnet Groups |
| [`api-gateway`](./modules/api-gateway) | REST API Gateway with Lambda integration, usage plans, and API keys | API GW, Lambda, IAM, CloudWatch Logs |
| [`iam`](./modules/iam) | Reusable IAM roles and policies following least-privilege principle | IAM Roles, Policies, Instance Profiles |
| [`cloudwatch`](./modules/cloudwatch) | Dashboards, alarms, and log groups for microservices observability | Dashboards, Alarms, SNS Topics, Log Groups |
| [`codepipeline`](./modules/codepipeline) | Full CI/CD pipeline: CodePipeline + CodeBuild + ECR + ECS deploy | CodePipeline, CodeBuild, ECR, S3 |

---

## 📁 Project structure

```
aws-terraform-infra-templates/
├── .github/
│   └── workflows/
│       └── terraform-ci.yml        # Plan on PR, Apply on merge
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── rds-aurora/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── elasticache/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── api-gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── cloudwatch/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── main.tf                 # Calls modules for dev
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
├── .terraform-version               # Pin Terraform version
├── .tflint.hcl                      # Linting rules
└── README.md
```

---

## 🚀 Quick start

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.6.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with sufficient IAM permissions

### Deploy a single module

```hcl
# In your own Terraform config, reference a module:

module "vpc" {
  source = "github.com/ajayp7tech/aws-terraform-infra-templates//modules/vpc"

  vpc_name           = "my-app-vpc"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true

  tags = {
    Environment = "dev"
    Project     = "my-app"
    Owner       = "ajay-pingali"
  }
}
```

### Deploy a full environment

```bash
cd environments/dev

# Initialise providers and modules
terraform init

# Preview what will be created
terraform plan -var-file="terraform.tfvars"

# Apply (creates all resources)
terraform apply -var-file="terraform.tfvars"

# Tear down when done
terraform destroy -var-file="terraform.tfvars"
```

---

## 🔧 Module usage examples

### EKS cluster

```hcl
module "eks" {
  source = "github.com/ajayp7tech/aws-terraform-infra-templates//modules/eks"

  cluster_name    = "my-app-eks"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids

  node_groups = {
    general = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 6
      desired_size   = 3
    }
  }
}
```

### RDS Aurora PostgreSQL

```hcl
module "rds" {
  source = "github.com/ajayp7tech/aws-terraform-infra-templates//modules/rds-aurora"

  cluster_identifier = "my-app-aurora"
  engine_version     = "15.4"
  instance_class     = "db.r6g.large"
  instance_count     = 2

  database_name = "appdb"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids

  backup_retention_period = 7
  deletion_protection     = true
  storage_encrypted       = true
}
```

### ElastiCache Redis

```hcl
module "redis" {
  source = "github.com/ajayp7tech/aws-terraform-infra-templates//modules/elasticache"

  cluster_id         = "my-app-redis"
  node_type          = "cache.t3.medium"
  num_cache_nodes    = 2
  automatic_failover = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  at_rest_encryption_enabled  = true
  transit_encryption_enabled  = true
}
```

---

## ⚙️ CI/CD pipeline

The GitHub Actions workflow runs on every PR and merge to main:

```
Pull Request opened
        │
        ├── terraform fmt  (check formatting)
        ├── terraform init
        ├── terraform validate
        ├── tflint (linting)
        └── terraform plan → posts plan output as PR comment

Merge to main
        │
        └── terraform apply (auto-apply to dev environment)
```

---

## 🔒 Security best practices applied

- All S3 state buckets have versioning and encryption enabled
- RDS and ElastiCache encryption at rest and in transit enforced by default
- IAM roles follow **least-privilege principle** — no wildcard `*` actions
- Security groups allow only minimum required ports between services
- Secrets stored in **AWS Secrets Manager**, never in `.tfvars` files
- `.tfstate` files stored remotely in S3 + DynamoDB state locking — never committed to Git

---

## 📊 Impact

These module patterns reflect infrastructure work that reduced environment provisioning time by **65%** and eliminated manual configuration drift across dev, QA, and production environments — replacing a process that previously required DevOps involvement for every deployment.

---

## 🗺 Roadmap

- [x] VPC, EKS, RDS Aurora, ElastiCache, API Gateway modules
- [x] Multi-environment structure (dev / staging / prod)
- [x] GitHub Actions CI with plan on PR
- [ ] CloudFront + WAF module
- [ ] MSK (Managed Kafka) module
- [ ] Terratest automated module testing
- [ ] Atlantis for GitOps-based Terraform workflows

---

## 👤 Author

**Ajay Pingali** — Senior Java Developer · AWS Certified Solutions Architect

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/ajayp7tech)
[![Portfolio](https://img.shields.io/badge/Portfolio-0f3460?style=flat-square&logo=github&logoColor=white)](https://ajayp7tech.github.io)
[![AWS Certified](https://img.shields.io/badge/AWS_Certified-232F3E?style=flat-square&logo=amazonaws&logoColor=white)](https://www.credly.com/badges/398e15b7-2fd7-426a-8d1d-d57f735a3fe1/public_url)

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
