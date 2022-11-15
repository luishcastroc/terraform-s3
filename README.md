# ci-cd-angular-terraform

Provisioning the necessary infrastructure (as code) with Terraform to host a Angular Website in AWS S3 delivered via CloudFront and implement codepipeline.
This script will create the following AWS Resources:

1. S3 Bucket
2. Cloudfront
3. Codepipeline
4. Connection between Codepipeline and GitHub
5. Codebuild
