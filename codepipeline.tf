resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-${var.aws_region}-${var.app_name}-${var.env_type}-${var.frontend}"  
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.bucket
  acl    = "private"
}

resource "aws_codestarconnections_connection" "simplification" {
  name          = var.codestarconnections_name
  provider_type = "GitHub"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.app_name}-${var.frontend}-${var.env_type}-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.simplification.arn
        FullRepositoryId = var.reponame
        BranchName       = var.repo_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.app_name}-${var.frontend}-${var.env_type}-codebuild"
      }
    }
  }
}
