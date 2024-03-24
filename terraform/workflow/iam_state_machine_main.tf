data "aws_iam_policy_document" "state_machine_check_duplicate_execution_iam_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "state_machine_check_duplicate_execution_iam_role" {
  name               = "state-machine-check-duplicate-execution"
  assume_role_policy = data.aws_iam_policy_document.state_machine_check_duplicate_execution_iam_role_document.json
}

data "aws_iam_policy_document" "state_machine_check_duplicate_execution_iam_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "states:ListExecutions"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "state_machine_check_duplicate_execution_iam_policy" {
  name   = "state-machine-check-duplicate-execution"
  policy = data.aws_iam_policy_document.state_machine_check_duplicate_execution_iam_policy_document.json
}

resource "aws_iam_policy_attachment" "state_check_duplicate_execution_role_policy" {
  name       = "state-machine-check-duplicate-policy-attachment"
  roles      = [aws_iam_role.state_machine_check_duplicate_execution_iam_role.name]
  policy_arn = aws_iam_policy.state_machine_check_duplicate_execution_iam_policy.arn
}
