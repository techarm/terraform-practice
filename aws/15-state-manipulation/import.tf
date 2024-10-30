/**
1. Import via CLI
2. Import via the import block
*/

# CLI
# terraform import aws_s3_bucket.remote_state "terraform-course-remote-state-backend"
resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-course-remote-state-backend"

  tags = {
    Managed   = "Terraform"
    Lifecycle = "Critical"
  }

  lifecycle {
    prevent_destroy = true
  }
}

import {
  id = aws_s3_bucket.remote_state.bucket
  to = aws_s3_bucket_public_access_block.remote_state
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
