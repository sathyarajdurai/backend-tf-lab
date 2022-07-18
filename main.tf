resource "aws_s3_bucket" "state_file_bucket" {
    bucket = "talent-academy-sathyaraj-lab-tfstates"

    tags = {
        Name = "talent-academy-sathyaraj-lab-tfstates"
        Environment = "Lab"
    }

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
    bucket = aws_s3_bucket.state_file_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "terraform-lock"
  }
}