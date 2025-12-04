# AWS S3 → Lambda → SES Automation (Terraform)

This project creates an automated pipeline where uploading any file to an S3 bucket will trigger a Lambda function that sends an email via Amazon SES.  
All infrastructure is deployed using Terraform.

---

## 🚀 Architecture Overview

1. **S3 Bucket**
   - Stores uploaded files
   - Triggers Lambda on `ObjectCreated` events

2. **Lambda Function**
   - Reads S3 event data
   - Sends email notification using AWS SES
   - Written in Python (handler.py)

3. **AWS SES**
   - Sends email notifications
   - Requires verified identities (sandbox mode)

4. **IAM Roles & Policies**
   - Least-privilege role for Lambda
   - Allows:
     - Reading S3 files
     - Sending SES emails
     - Writing CloudWatch logs

---

