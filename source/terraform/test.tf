variable "mversion" {}

variable "module" {
  default = "aws-cloudwatch-log-cleaner"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_lambda_function" "test_lambda" {
  s3_bucket        = "ci-cd-test-12345678"
  s3_key           = "${var.module}/${var.module}_${var.mversion}_code.zip"
  function_name    = "my_function"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs8.10"
}


output "version" {
  value = "${var.mversion}"
}
