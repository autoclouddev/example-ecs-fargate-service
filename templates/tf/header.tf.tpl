data "aws_region" "current" {}

## - Assume the target vpc name is in the format {namespace}-{environment}-main
data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["{{namespace}}-{{environment}}-main"]
  }
}

## - Assume the target subnet names are in the formation {namespace}-{environment}-main-{layer}-{short zone}
data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*{{layer}}*"]
  }
}

## - Assume the target cluster name is in the format {namespace}-{environment}-test
data "aws_ecs_cluster" "this" {
  cluster_name = "{{namespace}}-{{environment}}-test"
}