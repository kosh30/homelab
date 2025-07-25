# ## Authentication flow
# data "authentik_flow" "default-source-authentication" {
#   slug = "default-source-authentication"
# }
#
# resource "authentik_flow" "authentication" {
#   name               = "authentication-flow"
#   title              = "Welcome!"
#   slug               = "authentication-flow"
#   designation        = "authentication"
#   policy_engine_mode = "all"
# }
#
# resource "authentik_flow_stage_binding" "authentication-flow-binding-00" {
#   target = authentik_flow.authentication.uuid
#   stage  = authentik_stage_identification.authentication-identification.id
#   order  = 0
# }
#
# resource "authentik_flow_stage_binding" "authentication-flow-binding-10" {
#   target = authentik_flow.authentication.uuid
#   stage  = authentik_stage_authenticator_validate.authentication-mfa-validation.id
#   order  = 10
# }
#
# resource "authentik_flow_stage_binding" "authentication-flow-binding-100" {
#   target = authentik_flow.authentication.uuid
#   stage  = authentik_stage_user_login.authentication-login.id
#   order  = 100
# }
#
# ## Invalidation flow
# data "authentik_flow" "default-provider-invalidation-flow" {
#   slug = "default-provider-invalidation-flow"
# }
#
# resource "authentik_flow" "invalidation" {
#   name               = "invalidation-flow"
#   title              = "Invalidation Flow"
#   slug               = "invalidation-flow"
#   policy_engine_mode = "any"
#   designation        = "invalidation"
#   denied_action      = "continue"
#   # background         = "https://placeholder.jpeg"
# }
#
# resource "authentik_flow_stage_binding" "invalidation-flow-binding-00" {
#   target = authentik_flow.invalidation.uuid
#   stage  = authentik_stage_user_logout.invalidation-logout.id
#   order  = 0
# }
#
# ## Password recovery flow
# resource "authentik_flow" "recovery" {
#   name               = "recovery-flow"
#   title              = "Password recovery"
#   slug               = "password-recovery"
#   designation        = "recovery"
#   compatibility_mode = true
#   # background         = "https://placeholder.jpeg"
# }
#
# resource "authentik_flow_stage_binding" "recovery-flow-binding-00" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_identification.recovery-identification.id
#   order  = 0
# }
#
# resource "authentik_flow_stage_binding" "recovery-flow-binding-10" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_email.recovery-email.id
#   order  = 10
# }
#
# resource "authentik_flow_stage_binding" "recovery-flow-binding-20" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_prompt.password-change-prompt.id
#   order  = 20
# }
#
# resource "authentik_flow_stage_binding" "recovery-flow-binding-30" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_user_write.password-change-write.id
#   order  = 30
# }
#
# ## Invitation flow
#
# data "authentik_flow" "default-source-enrollment" {
#   slug = "default-source-enrollment"
# }
#
# resource "authentik_flow" "enrollment-invitation" {
#   name               = "enrollment-invitation-flow"
#   title              = "Enrollment invitation"
#   slug               = "enrollmment-invitation"
#   designation        = "enrollment"
#   compatibility_mode = true
#   # background         = "https://placeholder.jpeg"
# }
#
# resource "authentik_flow_stage_binding" "enrollment-invitation-flow-binding-00" {
#   target = authentik_flow.enrollment-invitation.uuid
#   stage  = authentik_stage_invitation.enrollment-invitation.id
#   order  = 0
# }
#
# resource "authentik_flow_stage_binding" "enrollment-invitation-flow-binding-10" {
#   target = authentik_flow.enrollment-invitation.uuid
#   stage  = authentik_stage_prompt.source-enrollment-prompt.id
#   order  = 10
# }
#
# resource "authentik_flow_stage_binding" "enrollment-invitation-flow-binding-20" {
#   target = authentik_flow.enrollment-invitation.uuid
#   stage  = authentik_stage_user_write.enrollment-user-write.id
#   order  = 20
# }
#
# resource "authentik_flow_stage_binding" "enrollment-invitation-flow-binding-30" {
#   target = authentik_flow.enrollment-invitation.uuid
#   stage  = authentik_stage_user_login.source-enrollment-login.id
#   order  = 30
# }
#
# ## User settings flow
# resource "authentik_flow" "user-settings" {
#   name               = "User settings"
#   title              = "Update your info"
#   slug               = "user-settings-flow"
#   policy_engine_mode = "any"
#   denied_action      = "message_continue"
#   designation        = "stage_configuration"
#   # background         = "https://placeholder.jpeg"
# }
#
# resource "authentik_flow_stage_binding" "user-settings-flow-binding-20" {
#   target = authentik_flow.user-settings.uuid
#   stage  = authentik_stage_prompt.user-settings.id
#   order  = 20
# }
#
# resource "authentik_flow_stage_binding" "user-settings-flow-binding-100" {
#   target = authentik_flow.user-settings.uuid
#   stage  = authentik_stage_user_write.user-settings-write.id
#   order  = 100
# }
#
# ## Authorization flow
# resource "authentik_flow" "provider-authorization-implicit-consent" {
#   name               = "Authorize Application"
#   title              = "Redirecting to %(app)s"
#   slug               = "provider-authorization-implicit-consent"
#   policy_engine_mode = "any"
#   denied_action      = "message_continue"
#   designation        = "authorization"
#   # background         = "https://placeholder.jpeg"
# }

// Builtin
data "authentik_flow" "default-authorization" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "default-invalidation" {
  slug = "default-invalidation-flow"
}

data "authentik_flow" "default-provider-invalidation" {
  slug = "default-provider-invalidation-flow"
}

data "authentik_flow" "default-user-settings" {
  slug = "default-user-settings-flow"
}

// Authentication
resource "authentik_flow" "authentication" {
  name        = "Welcome to authentik!"
  title       = "Welcome to authentik!"
  slug        = "authentication-flow"
  designation = "authentication"
  background  = "/static/dist/assets/images/flow_background.jpg"
}

resource "authentik_flow_stage_binding" "authentication-identification" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_identification.authentication-identification.id
  order  = 10
}

resource "authentik_flow_stage_binding" "authentication-mfa-validation" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_authenticator_validate.authentication-mfa-validation.id
  order  = 30
}

resource "authentik_flow_stage_binding" "authentication-login" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_user_login.authentication-login.id
  order  = 100
}

// Recovery
resource "authentik_flow" "recovery" {
  name               = "recovery-flow"
  title              = "Password recovery"
  slug               = "password-recovery"
  designation        = "recovery"
  compatibility_mode = true
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-00" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_identification.recovery-identification.id
  order  = 0
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-10" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_email.recovery-email.id
  order  = 10
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-20" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_prompt.password-change-prompt.id
  order  = 20
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-30" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_user_write.password-change-write.id
  order  = 30
}
