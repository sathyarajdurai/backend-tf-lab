resource "aws_s3_bucket" "state_file_bucket" {
    bucket = "talent-academy-sathyaraj-lab-tfstates-sep"

    tags = {
        Name = "talent-academy-sathyaraj-lab-tfstates-sep"
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

resource "aws_kms_key" "be_kms" {
  description             = "backend-kms"
  #deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_encryption" {
  bucket = aws_s3_bucket.state_file_bucket.id
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.be_kms.arn
        #sse_algorithm     = "AES256"
        sse_algorithm     = "aws:kms"
      }
    }
  }

resource "aws_kms_alias" "be_kms_alias" {
  name          = "alias/backendkms"
  target_key_id = aws_kms_key.be_kms.key_id
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