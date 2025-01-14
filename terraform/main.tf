provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "s3" {
  source = "./s3"
}

module "ecs" {
  source = "./ecs"
  s3_bucket_name = module.s3.bucket_name
}

module "dynamodb" {
  source = "./dynamodb"
}

module "lambda" {
  source = "./lambda"
}

module "cloudfront" {
  source = "./cloudfront"
}
