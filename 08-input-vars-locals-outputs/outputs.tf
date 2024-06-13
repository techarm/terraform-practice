output "s3_bucket_name" {
  description = "The name of the S3 bucket for the project."
  value       = aws_s3_bucket.projecjt_bucket.bucket
  sensitive = true # terraform outputコマンドから表示できる、ターミナルに表示しない
}