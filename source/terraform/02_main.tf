resource "aws_iam_role" "lambda" {
  name = "${var.project}-${var.stage}-${var.obcon_module_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.obcon_module_bucket}"
  s3_key        = "${var.obcon_module_name}/${var.obcon_module_name}_${var.obcon_module_version}_code.zip"
  function_name = "${var.project}-${var.stage}-${var.obcon_module_name}"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "main.handler"
  runtime       = "python3.6"

  environment {
    variables = {
      rentation_in_days = "${var.rentation_in_days}"
    }
  }
}

resource "aws_lambda_permission" "cloudwatch" {
  statement_id  = "AllowExecutionFromCloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.cron.arn}"
}

resource "aws_cloudwatch_event_rule" "cron" {
  name                = "${var.project}-${var.stage}-${var.obcon_module_name}"
  schedule_expression = "cron(* * * * ? *)"
}

resource "aws_cloudwatch_event_target" "cron" {
  arn  = "${aws_lambda_function.lambda.arn}"
  rule = "${aws_cloudwatch_event_rule.cron.name}"
}
