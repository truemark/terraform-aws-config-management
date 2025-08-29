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
}

variable "delivery_s3_key_prefix" {
  description = "S3 key prefix for AWS Config delivery channel"
  type        = string
  default     = "config"
}

variable "excluded_accounts" {
  description = "AWS accounts to exclude from the conformance packs"
  type        = list(string)
  default     = []
}
