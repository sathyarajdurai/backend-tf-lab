terraform {
    backend "s3" {
        bucket = "talent-academy-sathyaraj-lab-tfstates"
        key = "talent-academy/backend/terraform.tfstates"
    }
}