resource "aws_ecs_cluster" "main" {
  name = "game-highlights-cluster"
}

resource "aws_ecs_task_definition" "api_task" {
  family                   = "api-poller-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([{
    name  = "api-poller",
    image = "your-dockerhub-image:latest",
    essential = true,
    environment = [
      {
        name  = "RAPIDAPI_KEY",
        value = var.rapidapi_key
      },
      {
        name  = "S3_BUCKET",
        value = var.s3_bucket_name
      }
    ]
  }])
}
