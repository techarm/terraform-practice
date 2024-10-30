resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "projecjt_bucket" {
  bucket = "08-input-vars-locals-outputs-${random_id.bucket_suffix.hex}"
}