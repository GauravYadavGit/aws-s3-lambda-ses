output "s3_bucket_name" {
  description = "The name of the S3 bucket used for file uploads"
  value       = aws_s3_bucket.upload_bucket.bucket
}

output "lambda_function_name" {
  description = "Lambda function triggered by S3 uploads"
  value       = aws_lambda_function.s3_ses_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = aws_lambda_function.s3_ses_lambda.arn
}

output "iam_role_name" {
  description = "IAM role attached to the Lambda function"
  value       = aws_iam_role.lambda_role.name
}
