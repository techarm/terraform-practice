import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-3caie4i6"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::090194995703:policy/service-role/AWSLambdaBasicExecutionRole-45d95d05-de6e-4e20-96c6-910812c8f58c"
}

# jsonencode({
#   Statement = [{
#     Action = "sts:AssumeRole"
#     Effect = "Allow"
#     Principal = {
#       Service = "lambda.amazonaws.com"
#     }
#   }]
#   Version = "2012-10-17"
# })
data "aws_iam_policy_document" "assume_lambda_execution_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# jsonencode({
#   Statement = [
#     {
#       Action   = "logs:CreateLogGroup"
#       Effect   = "Allow"
#       Resource = "arn:aws:logs:ap-northeast-3:090194995703:*"
#     },
#     {
#       Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
#       Effect   = "Allow"
#       Resource = ["arn:aws:logs:ap-northeast-3:090194995703:log-group:/aws/lambda/manually-created-lambda:*"]
#     }
#   ]
#   Version = "2012-10-17"
# })
data "aws_iam_policy_document" "lambda_execution" {
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*",
    ]
    actions = ["logs:CreateLogGroup"]
  }

  statement {
    effect = "Allow"
    resources = [
      # "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/manually-created-lambda:*"
      "${aws_cloudwatch_log_group.lambda.arn}:*"
    ]
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name   = "AWSLambdaBasicExecutionRole-45d95d05-de6e-4e20-96c6-910812c8f58c"
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.lambda_execution.json
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy  = data.aws_iam_policy_document.assume_lambda_execution_role.json
  managed_policy_arns = [aws_iam_policy.lambda_execution.arn]
  name                = "manually-created-lambda-role-3caie4i6"
  path                = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}
