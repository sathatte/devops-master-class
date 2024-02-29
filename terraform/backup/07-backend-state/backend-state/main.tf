provider "aws" {
  region = "us-east-1"
  //version = "~> 2.46"
}

//S3 bucket
resource "aws_s3_bucket" "enterprise_backend_state" {
  bucket = "dev-applications-backend-state-in28minutes-abc"

  lifecycle {
    prevent_destroy = true
  }

  #    versioning {
  #        enabled = true
  #    }
  #
  #    server_side_encryption_configuration {
  #        rule {
  #            apply_server_side_encryption_by_default {
  #                sse_algorithm = "AES256"
  #            }
  #        }
  #    }

  tags = {
    yor_trace = "f68ba246-0e50-4079-804b-23fefd94c1d2"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.enterprise_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.enterprise_backend_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

//Locking - Dynamo DB

resource "aws_dynamodb_table" "enterprise_backend_lock" {
  name         = "dev_application_locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    yor_trace = "b76cf109-2136-4dfb-8168-f9ce04b5fc7f"
  }
}