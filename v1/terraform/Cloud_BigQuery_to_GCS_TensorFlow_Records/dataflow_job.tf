# Autogenerated file. DO NOT EDIT.
#
# Copyright (C) {{currentYear}} Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#

variable "readQuery" {
  type = string
  description = "SQL query in standard SQL to pull data from BigQuery"
}

variable "readIdColumn" {
  type = string
  description = "Name of the BigQuery column storing the unique identifier of the row"
  default = ""
}

variable "invalidOutputPath" {
  type = string
  description = "Cloud Storage path where to write BigQuery rows that cannot be converted to target entities. (Example: gs://your-bucket/your-path)"
  default = ""
}

variable "outputDirectory" {
  type = string
  description = "Cloud Storage directory to store output TFRecord files. (Example: gs://your-bucket/your-path)"
}

variable "outputSuffix" {
  type = string
  description = "File suffix to append to TFRecord files. Defaults to .tfrecord"
  default = ".tfrecord"
}

variable "trainingPercentage" {
  type = string
  description = "Defaults to 1 or 100%. Should be decimal between 0 and 1 inclusive"
  default = "1.0"
}

variable "testingPercentage" {
  type = string
  description = "Defaults to 0 or 0%. Should be decimal between 0 and 1 inclusive"
  default = "0.0"
}

variable "validationPercentage" {
  type = string
  description = "Defaults to 0 or 0%. Should be decimal between 0 and 1 inclusive"
  default = "0.0"
}


variable "additional_experiments" {
  type        = set(string)
  description = "List of experiments that should be used by the job. An example value is  'enable_stackdriver_agent_metrics'."
  default     = null
}

variable "effective_labels" {
  type        = map(string)
  description = "All of labels (key/value pairs) present on the resource in GCP, including the labels configured through Terraform, other clients and services."
}

variable "enable_streaming_engine" {
  type        = bool
  description = "Indicates if the job should use the streaming engine feature."
  default     = null
}

variable "ip_configuration" {
  type        = string
  description = "The configuration for VM IPs. Options are 'WORKER_IP_PUBLIC' or 'WORKER_IP_PRIVATE'."
  default     = null
}

variable "kms_key_name" {
  type        = string
  description = "The name for the Cloud KMS key for the job. Key format is: projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING/cryptoKeys/KEY"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "User labels to be specified for the job. Keys and values should follow the restrictions specified in the labeling restrictions page. NOTE: This field is non-authoritative, and will only manage the labels present in your configuration.				Please refer to the field 'effective_labels' for all of the labels present on the resource."
  default     = null
}

variable "machine_type" {
  type        = string
  description = "The machine type to use for the job."
  default     = null
}

variable "max_workers" {
  type        = number
  description = "The number of workers permitted to work on the job. More workers may improve processing speed at additional cost."
  default     = null
}

variable "name" {
  type        = string
  description = "A unique name for the resource, required by Dataflow."
}

variable "network" {
  type        = string
  description = "The network to which VMs will be assigned. If it is not provided, 'default' will be used."
  default     = null
}

variable "on_delete" {
  type        = string
  description = "One of 'drain' or 'cancel'. Specifies behavior of deletion during terraform destroy."
  default     = null
}

variable "project" {
  type        = string
  description = "The project in which the resource belongs."
  default     = null
}

variable "region" {
  type        = string
  description = "The region in which the created job should run."
  default     = null
}

variable "service_account_email" {
  type        = string
  description = "The Service Account email used to create the job."
  default     = null
}

variable "skip_wait_on_job_termination" {
  type        = bool
  description = "If true, treat DRAINING and CANCELLING as terminal job states and do not wait for further changes before removing from terraform state and moving on. WARNING: this will lead to job name conflicts if you do not ensure that the job names are different, e.g. by embedding a release ID or by using a random_id."
  default     = null
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to which VMs will be assigned. Should be of the form 'regions/REGION/subnetworks/SUBNETWORK'."
  default     = null
}

variable "temp_gcs_location" {
  type        = string
  description = "A writeable location on Google Cloud Storage for the Dataflow job to dump its temporary data."
}

variable "template_gcs_path" {
  type        = string
  description = "The Google Cloud Storage path to the Dataflow job template."
}

variable "terraform_labels" {
  type        = map(string)
  description = "The combination of labels configured directly on the resource and default labels configured on the provider."
}


variable "transform_name_mapping" {
  type        = map(string)
  description = "Only applicable when updating a pipeline. Map of transform name prefixes of the job to be replaced with the corresponding name prefixes of the new job."
  default     = null
}

variable "zone" {
  type        = string
  description = "The zone in which the created job should run. If it is not provided, the provider zone is used."
  default     = null
}

resource "google_dataflow_job" "generated" {
  parameters = {
    readQuery = var.readQuery
    readIdColumn = var.readIdColumn
    invalidOutputPath = var.invalidOutputPath
    outputDirectory = var.outputDirectory
    outputSuffix = var.outputSuffix
    trainingPercentage = var.trainingPercentage
    testingPercentage = var.testingPercentage
    validationPercentage = var.validationPercentage
  }

  additional_experiments = var.additional_experiments

  effective_labels = var.effective_labels

  enable_streaming_engine = var.enable_streaming_engine

  ip_configuration = var.ip_configuration

  kms_key_name = var.kms_key_name

  labels = var.labels

  machine_type = var.machine_type

  max_workers = var.max_workers

  name = var.name

  network = var.network

  on_delete = var.on_delete

  project = var.project

  region = var.region

  service_account_email = var.service_account_email

  skip_wait_on_job_termination = var.skip_wait_on_job_termination

  subnetwork = var.subnetwork

  temp_gcs_location = var.temp_gcs_location

  template_gcs_path = var.template_gcs_path

  terraform_labels = var.terraform_labels

  transform_name_mapping = var.transform_name_mapping

  zone = var.zone
}
