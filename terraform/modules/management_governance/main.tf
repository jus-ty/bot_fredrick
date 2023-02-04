# SSM Parameter - email
resource "aws_ssm_parameter" "service_account_email" {
  name    = "${var.ssm_parameter_account_email_name}"
  type    = "String"
  value   = "${var.ssm_parameter_account_email_value}"
  tags    = var.ssm_parameter_account_email_tags
}

# SSM Parameter - password
resource "aws_ssm_parameter" "service_account_password" {
  name    = "${var.ssm_parameter_account_password_name}"
  type    = "String"
  value   = "${var.ssm_parameter_account_password_value}"
  tags    = var.ssm_parameter_account_password_tags
}

# SSM Parameter - thread_id
resource "aws_ssm_parameter" "thread_id" {
  name    = "${var.ssm_parameter_thread_id_name}"
  type    = "String"
  value   = "${var.ssm_parameter_thread_id_value}"
  tags    = var.ssm_parameter_thread_id_tags
}

# IAM Role for SSM Automation
resource "aws_iam_role" "ssm_automation_iam_role" {
  name                = "${var.ssm_automation_iam_role_name}"
  assume_role_policy  = "${data.aws_iam_policy_document.ssm_trust_policy.json}"
  tags                = var.ssm_automation_iam_role_tags
}


data "aws_iam_policy_document" "ssm_trust_policy" {
  statement {
    actions           = ["sts:AssumeRole"]
    effect            = "Allow"
    principals {
      type            = "Service"
      identifiers     = ["ssm.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ssm_automation_iam_policy_attach" {
  role                = aws_iam_role.ssm_automation_iam_role.name
  policy_arn          = aws_iam_policy.ssm_automation_iam_policy.arn
}

resource "aws_iam_policy" "ssm_automation_iam_policy" {
  name                = "${var.ssm_automation_iam_policy_name}"
  policy              = data.aws_iam_policy_document.ssm_automation_iam_policy_document.json
  tags                = "${var.ssm_automation_iam_policy_tags}"
}

data "aws_iam_policy_document" "ssm_automation_iam_policy_document" {
  statement {
    sid               = "AllowSSMStopStartNATEC2Instance"

    effect            = "Allow"

    actions           = [
      "ec2:DescribeInstanceStatus",
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]

    resources         = [
      "${var.nat_instance_ec2_arn}"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "AmazonSSMFullAccess_to_SSMRole" {
  role                = "${aws_iam_role.ssm_automation_iam_role.name}"
  policy_arn          = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# SSM Maintenance windows

resource "aws_ssm_maintenance_window" "start_nat_instance_maintenance_window" {
  name                = "${var.ssm_automation_start_maintenance_window_name}"
  description         = "Maintenance window to start the NAT instance"
  schedule            = "${var.ssm_automation_start_cron_schedule}"
  cutoff              = 0
  duration            = 1
  tags                = "${var.ssm_automation_start_maintenance_window_tags}"
}

resource "aws_ssm_maintenance_window_task" "start_nat_instance_task" {
  name                = "${var.ssm_automation_start_task_name}"
  description         = "Task to start the NAT instance"
  window_id           = aws_ssm_maintenance_window.start_nat_instance_maintenance_window.id
  task_type           = "AUTOMATION"
  task_arn            = "AWS-StartEC2Instance"
  service_role_arn    = aws_iam_role.ssm_automation_iam_role.arn

  task_invocation_parameters {
  automation_parameters {
    document_version = "$LATEST"

    parameter {
      name   = "InstanceId"
      values = [var.nat_instance_ec2_id]
    }
  }
}
}

resource "aws_ssm_maintenance_window" "stop_nat_instance_maintenance_window" {
  name                = "${var.ssm_automation_stop_maintenance_window_name}"
  description         = "Maintenance window to stop the NAT instance"
  schedule            = "${var.ssm_automation_stop_cron_schedule}"
  cutoff              = 0
  duration            = 1
  tags                = "${var.ssm_automation_stop_maintenance_window_tags}"
}

resource "aws_ssm_maintenance_window_task" "stop_nat_instance_task" {
  name                = "${var.ssm_automation_stop_task_name}"
  description         = "Task to stop the NAT instance"
  window_id           = aws_ssm_maintenance_window.stop_nat_instance_maintenance_window.id
  task_type           = "AUTOMATION"
  task_arn            = "AWS-StopEC2Instance"
  service_role_arn    = aws_iam_role.ssm_automation_iam_role.arn

  task_invocation_parameters {
  automation_parameters {
    document_version = "$LATEST"

    parameter {
      name   = "InstanceId"
      values = [var.nat_instance_ec2_id]
    }
  }
}
}