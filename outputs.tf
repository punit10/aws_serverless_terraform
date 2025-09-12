# OUTPUTS
output "lambda_arn" {
  value = aws_lambda_function.random_sentence.arn
}

#output "api_endpoint" {
#  value = "${aws_api_gateway_deployment.sentence_deployment.invoke_url}/sentence"
#}


output "api_endpoint" {
  value = "https://${aws_api_gateway_rest_api.sentence_api.id}.execute-api.${var.aws_region}.amazonaws.com/${aws_api_gateway_stage.dev_stage.stage_name}/sentence"
}
