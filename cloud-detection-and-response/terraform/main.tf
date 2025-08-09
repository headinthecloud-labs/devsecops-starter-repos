terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" { region = var.region }

resource "aws_iam_role" "lambda" {
  name = "cdr-disable-key"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_inline" {
  role = aws_iam_role.lambda.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["iam:UpdateAccessKey"],
      Resource = "*"
    },{
      Effect: "Allow",
      Action: ["logs:CreateLogGroup","logs:CreateLogStream","logs:PutLogEvents"],
      Resource: "*"
    }]
  })
}

resource "aws_lambda_function" "disable_key" {
  function_name = "cdr-disable-key"
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"
  runtime       = "python3.11"
  filename      = "../lambda/disable_key/index.py"
  source_code_hash = filebase64sha256("../lambda/disable_key/index.py")
}

# You can add an EventBridge rule and pattern here later.