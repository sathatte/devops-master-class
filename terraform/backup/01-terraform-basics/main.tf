provider "aws" {
  region = "us-east-1"
  //version = "~> 2.46" (No longer necessary)
}

# plan - execute 
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-s3-bucket-in28minutes-rangak-002"
  #   versioning {
  #       enabled = true
  #   }
  tags = {
    yor_trace = "eb78885f-3ab2-4b7c-bf4c-18a8c6e2e01b"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user_abc_updated"
  tags = {
    yor_trace = "b51da162-a4e3-4d2a-90c1-45630f3af15c"
  }
}