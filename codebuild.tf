data "template_file" "buildspec" {
  template = "${file("buildspec.yml")}"
  vars = {
      s3bucket = aws_s3_bucket.bucket.bucket
      cfid = aws_cloudfront_distribution.s3_distribution.id
      folder = var.folder
    }
}

resource "aws_codebuild_project" "static_web_build" {
  badge_enabled  = false
  name           = "${var.app_name}-${var.frontend}-${var.env_type}-codebuild"
  service_role   = aws_iam_role.codebuild_role.arn

  artifacts {
    encryption_disabled    = false
    name                   = "${var.app_name}-${var.frontend}-${var.env_type}-codebuild"
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    buildspec           = data.template_file.buildspec.rendered
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }
}
