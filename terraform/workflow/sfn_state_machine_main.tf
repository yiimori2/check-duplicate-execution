resource "aws_sfn_state_machine" "state_machine_check_duplicate_execution" {
  name     = "check-duplicate-execution"
  role_arn = aws_iam_role.state_machine_check_duplicate_execution_iam_role.arn
  definition = jsonencode(yamldecode(templatefile("${path.module}/templates/state_machine/check_duplicate_execution.asl.yaml", {
    aws_account_id = data.aws_caller_identity.current.account_id
    }
    )
  ))
}
