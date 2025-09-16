# Create API Gateway
resource "aws_api_gateway_rest_api" "sentence_api" {
  name        = "RandomSentenceAPI"
  description = "API that returns a random sentence"
}

# Resource under root "/sentence"
resource "aws_api_gateway_resource" "sentence_resource" {
  rest_api_id = aws_api_gateway_rest_api.sentence_api.id
  parent_id   = aws_api_gateway_rest_api.sentence_api.root_resource_id
  path_part   = "sentence"
}

# Method (GET)
resource "aws_api_gateway_method" "get_sentence" {
  rest_api_id   = aws_api_gateway_rest_api.sentence_api.id
  resource_id   = aws_api_gateway_resource.sentence_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integration with Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sentence_api.id
  resource_id             = aws_api_gateway_resource.sentence_resource.id
  http_method             = aws_api_gateway_method.get_sentence.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.random_sentence.invoke_arn
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.random_sentence.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sentence_api.execution_arn}/*/*"
}

# Deploy API Gateway
resource "aws_api_gateway_deployment" "sentence_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.sentence_api.id
}

# Stage (instead of stage_name in deployment)
resource "aws_api_gateway_stage" "dev_stage" {
  rest_api_id   = aws_api_gateway_rest_api.sentence_api.id
  deployment_id = aws_api_gateway_deployment.sentence_deployment.id
  stage_name    = "dev"
}
