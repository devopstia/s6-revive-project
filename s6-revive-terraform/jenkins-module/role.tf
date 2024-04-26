resource "aws_iam_role" "jenkins_revive_role" {
  name = format("%s-%s-jenkins-role", var.tags["project"], var.tags["environment"])
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
resource "aws_iam_policy" "jenkins_revive_ec2_full_access" {
  name        = format("%s-%s-jenkins-policy", var.tags["project"], var.tags["environment"])
  description = "EC2 full access policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "ec2:*",
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "jenkins_revive_role_attachment" {
  name       = format("%s-%s-jenkins-policy-attachment", var.tags["project"], var.tags["environment"])
  roles      = [aws_iam_role.jenkins_revive_role.name]
  policy_arn = aws_iam_policy.jenkins_revive_ec2_full_access.arn
}

resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
  name = format("%s-%s-jenkins-master-instance-profile", var.tags["project"], var.tags["environment"])
  role = aws_iam_role.jenkins_revive_role.name
}

