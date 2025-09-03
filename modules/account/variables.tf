variable "conformance_packs" {
  description = "A map of conformance packs to create"
  type        = any
  default     = {}
}

variable "pack_name_prefix" {
  description = "Conformance pack names created should start with the specified string"
  type        = string
  default     = ""
}

variable "delivery_s3_bucket" {
  description = "S3 bucket for AWS Config delivery channel"
  type        = string
  default     = null
}

variable "delivery_s3_key_prefix" {
  description = "S3 key prefix for AWS Config delivery channel"
  type        = string
  default     = "config"
}

variable "create_config_recorder" {
  description = "Whether to create AWS Config configuration recorder"
  type        = bool
  default     = true
}

variable "config_recorder_name" {
  description = "Name for the AWS Config configuration recorder"
  type        = string
  default     = "default"
}

variable "config_recorder_role_arn" {
  description = "IAM role ARN for AWS Config configuration recorder"
  type        = string
  default     = null
}

variable "create_delivery_channel" {
  description = "Whether to create AWS Config delivery channel"
  type        = bool
  default     = true
}

variable "delivery_channel_name" {
  description = "Name for the AWS Config delivery channel"
  type        = string
  default     = "default"
}
