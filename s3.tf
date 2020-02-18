resource "aws_s3_bucket" "bucket" {
  bucket        = var.s3_bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.s3_logging_bucket_name
    target_prefix = "${var.s3_logging_bucket_prefix}/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id      = "delete"
    enabled = true

    expiration {
      days = 7
    }
  }

  tags = {
    Name = "${upper(var.project_name)} Inventory Report"
  }
}
