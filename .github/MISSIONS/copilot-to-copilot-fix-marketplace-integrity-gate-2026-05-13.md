Parent_Agent: copilot
Child_Agent: copilot
Mission_Objective: Resolve Marketplace Integrity workflow failure for this PR by satisfying the mission protocol gate for the non-trivial change in .github/scripts/validate-registry-paths.sh.
Context_Links:
  - PR #2 (fix bash heredoc parsing in registry path validation script)
  - Workflow: Marketplace Integrity
  - Trigger file: .github/scripts/validate-registry-paths.sh
Success_Criteria:
  - Add a valid mission file under .github/MISSIONS with all mandatory keys populated.
  - Ensure mission protocol validation passes for the current BASE_SHA...HEAD_SHA range.
Result_Payload:
  - Mission file committed in this branch.
  - CI mission protocol gate no longer fails due to missing mission file.
