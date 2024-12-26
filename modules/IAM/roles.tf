# Data sources to fetch AWS managed policy ARNs
data "aws_iam_policy" "managed_policy1" {
  name = "AmazonS3ReadOnlyAccess"
}

data "aws_iam_policy" "managed_policy2" {
  name = "AmazonSSMManagedInstanceCore"
}

# Create IAM role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the first managed policy to the role
resource "aws_iam_role_policy_attachment" "policy1_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.managed_policy1.arn
}

# Attach the second managed policy to the role
resource "aws_iam_role_policy_attachment" "policy2_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.managed_policy2.arn
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2_role.name
}