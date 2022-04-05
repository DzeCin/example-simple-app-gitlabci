variable deployName {
  type        = string
  default     = "app"
  description = "Deployment name"
}

variable namespace {
  type = string
  default = "dcindrak"
  description = "Namespace to deploy the app to" 
}

variable serviceName {
  type = string
  default = "app"
}