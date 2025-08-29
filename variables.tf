variable "conformance_packs" {
  description = "A list of conformance packs to deploy (e.g., ['nist-800-171'])"
  type        = list(string)
  default     = []
}

variable "conformance_pack_parameters" {
  description = "Parameters to override for specific conformance packs"
  type        = map(map(string))
  default     = {}
}

variable "conformance_packs_to_exclude" {
  description = "A list of conformance packs to exclude from deployment"
  type        = list(string)
  default     = []
}

variable "template_version" {
  description = "Template version to use (commit hash, tag, or 'latest')"
  type        = string
  default     = "latest"
}

variable "excluded_accounts" {
  description = "AWS accounts to exclude from the conformance packs (organization mode only)"
  type        = list(string)
  default     = []
}

variable "organization_managed" {
  description = "Whether the conformance packs should be organization managed"
  type        = bool
  default     = false
}

variable "pack_name_prefix" {
  description = "Conformance pack names created should start with the specified string"
  type        = string
  default     = ""
}

variable "delivery_s3_bucket" {
  description = "S3 bucket for AWS Config delivery channel (auto-discovered if not provided)"
  type        = string
  default     = null
}

variable "delivery_s3_key_prefix" {
  description = "S3 key prefix for AWS Config delivery channel"
  type        = string
  default     = "config"
}

variable "create_config_recorder" {
  description = "Whether to create AWS Config configuration recorder (account mode only)"
  type        = bool
  default     = true
}

variable "config_recorder_name" {
  description = "Name for the AWS Config configuration recorder (account mode only)"
  type        = string
  default     = "default"
}

variable "config_recorder_role_arn" {
  description = "IAM role ARN for AWS Config configuration recorder (auto-discovered if not provided, account mode only)"
  type        = string
  default     = null
}

variable "create_delivery_channel" {
  description = "Whether to create AWS Config delivery channel (account mode only)"
  type        = bool
  default     = true
}

variable "delivery_channel_name" {
  description = "Name for the AWS Config delivery channel (account mode only)"
  type        = string
  default     = "default"
}
