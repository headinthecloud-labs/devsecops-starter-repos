package kubernetes.admission

import data.lib.kubernetes.helpers as helpers

deny[msg] {
  input.request.kind.kind == "Pod"
  containers := input.request.object.spec.containers
  some i
  containers[i].securityContext.privileged == true
  msg := sprintf("Privileged container '%s' is not allowed", [containers[i].name])
}