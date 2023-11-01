terraform {
    backend "s3" {
        bucket = "talent-academy-sathyaraj-lab-tfstates-sep"
        key = "talent-academy/backend-s3/terraform.tfstates"
        dynamodb_table = "terraform-lock"
    }
}