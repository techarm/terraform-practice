import {
  to = aws_cloudwatch_log_group.lambda
  id = "/aws/lambda/manually-created-lambda"
}

resource "aws_cloudwatch_log_group" "lambda" {
  log_group_class = "STANDARD"
  name            = "/aws/lambda/manually-created-lambda"
}
