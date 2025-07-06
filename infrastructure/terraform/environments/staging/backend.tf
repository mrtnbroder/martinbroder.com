terraform {
  backend "s3" {
    bucket = "martinbroder-com-s3-terraform-state" # The bucket you created earlier
    key    = "martinbroder-com/staging.tfstate"    # <-- UNIQUE KEY
    region = "eu-central-1"                        # The region where your bucket is located
  }
}
