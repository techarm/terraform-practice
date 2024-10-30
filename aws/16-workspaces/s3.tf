resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_bucket" {
  count  = var.s3_count
  bucket = "16-workspace-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
}
