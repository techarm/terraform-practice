## Google Cloud Login

- gcloud init
- gcloud auth application-default login

## Terraform Language Basic

### Top Levle & Block inside Blocks

**Top Level Blocks**

- Fundamental Blocks
  - resource
  - provider
  - terraform
- Variable Blocks
  - Input Variables Block
  - Output Values Block
  - Local Values Block
- Calling / Referencing Blocks
  - Data Sources Block
  - Models Block
- New Blocks - Added Recently
  - Import Block
  - Moved Block
  - Removed Block
  - Check Block

**Block Inside Blocks**: provisioners, resorce specific blocks like tags

### Variable

- Priority-1: Any `--var=NAME=VALUE` and `-var-file` options on the command line, in the order they are provided.
- Priority-2: Any _.auto.tfvars or _.auto.tfvars.json files, processed in lexical order of their filenames.
- Priority-3: The terraform.tfvars.json file, if present.
- Priority-4: The terraform.tfvars file, if present.
- Priority-5: Environment variables

  ```
  # Set Environment Variable
  export TF_VAR_machine_type="e2-standard-2"
  echo $TF_VAR_machine_type

  # Unset Environment variable
  unset F_VAR_machine_type
  echo $TF_VAR_machine_type
  ```
