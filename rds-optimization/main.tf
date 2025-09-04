data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Permissions policy: full RDS access
data "aws_iam_policy_document" "lambda_rds_access" {
  statement {
    effect = "Allow"

    actions = [
        "rds:DescribeDBClusterParameters",
        "rds:StartDBCluster",
        "rds:StopDBCluster",
        "rds:StopDBInstance",
        "rds:StartDBInstance",
        "rds:ListTagsForResource",
        "rds:DescribeDBInstances",
        "rds:DescribeSourceRegions",
        "rds:DescribeDBClusterEndpoints",
        "rds:DescribeDBClusters",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}

# Create IAM policy from the above document
resource "aws_iam_policy" "lambda_rds_policy" {
  name   = "lambda_rds_full_access"
  policy = data.aws_iam_policy_document.lambda_rds_access.json
}

# Attach the RDS access policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_rds_policy_attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_rds_policy.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "rds_stop.py"
  output_path = "rds_stop_code.zip"
}

resource "aws_lambda_function" "lambda_rds_stop" {
  filename      = "rds_stop_code.zip"
  function_name = "${var.lambda_function_name}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "rds_stop.lambda_handler"  # <filename>.<function_name>

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.13"
  depends_on = [
    aws_iam_role_policy_attachment.lambda_rds_policy_attach,
    aws_cloudwatch_log_group.lambda_rds_stop_log_group,
  ]

}

resource "aws_cloudwatch_log_group" "lambda_rds_stop_log_group" {
  name = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days= 30  
}
