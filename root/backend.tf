terraform {
  backend "s3" {
    bucket         = "state-wh-demo"
    key            = "backend/wh-demo.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "state-locking-wh-demo"
  }
}