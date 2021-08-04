variable "google_project_id" {
  type = string
}

variable "google_region" {
  type = string
}

variable "bigquery_region" {
  type = string
  validation {
    condition = (
      contains(["US", "EU"], var.bigquery_region)
    )
    error_message = "The value for 'bigquery_region' must be one of: 'US','EU'."
  }
}

variable "parsers" {
  description = "list of data parsers to configure (e.g. 'gitlab','tekton')"
  type        = list(any)
}

/*  The default for normal usage is true, because VCS webhooks need to call the endpoint over the
    public internet (with auth provided by the security token). But some deployments (including CI
    E2E tests on Google infra) will require this to be false. */
variable "make_event_handler_public" {
  description = "If true, the event handler endpoint will be accessible by unauthenticated users."
  type        = bool
  default     = true
}

variable "cloud_build_triggers" {
  description = "List of artifacts to be published to the Artifacts registry"
  type = list(object({
    name          = string
    description   = string
    cloudbuild    = string
    owner         = string
    repository    = string
    branch        = string
    include       = list(string)
    substitutions = map(string)
    invert_regex  = bool
  }))
}
