terraform {
  required_providers {
    awslambda = {
      source = "dedunumax/awslambda"
      version = "1.0.4"
    }
  }
}

provider "awslambda" {
  region   = "us-west-1"
  profile  = "default"
  role_arn = "arn:aws:iam::account-id:role/role-name-with-path"
}

resource "aws_lambda_invocation" "example" {
  function_name = "${aws_lambda_function.lambda_function_test.function_name}"

  input = <<JSON
 {
   "key1": "value1",
   "key2": "value2"
 }
 JSON
}

output "result_entry" {
  value = jsondecode(aws_lambda_invocation.example.result)["key1"]
}
