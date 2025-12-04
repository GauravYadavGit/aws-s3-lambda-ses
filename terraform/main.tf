
# 1. S3 Bucket


resource "aws_s3_bucket" "upload_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "S3-Lambda-SES"
    Owner   = "Gaurav"
  }
}


# 2. Package Lambda Function as ZIP

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/lambda.zip"
}


# 3. Lambda Function Deployment


resource "aws_lambda_function" "s3_ses_lambda" {
  function_name = "s3-to-ses-lambda"
  filename      = data.archive_file.lambda_zip.output_path
  handler       = "handler.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_role.arn

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      SENDER_EMAIL    = var.sender_email
      RECIPIENT_EMAIL = var.recipient_email
    }
  }
}


# 4. Allow S3 to trigger Lambda


resource "aws_lambda_permission" "allow_s3_to_call_lambda" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_ses_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.upload_bucket.arn
}


# 5. S3 Event Notification -> Lambda Trigger


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.upload_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_ses_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [
    aws_lambda_permission.allow_s3_to_call_lambda
  ]
}
