# Terragrunt Infrastructure Management

## Overview

This directory contains the Terragrunt configuration for managing the project's infrastructure. It follows a DRY (Don't Repeat Yourself) principle, using a hierarchical structure to manage different environments (e.g., `dev`, `pre-prod`, `prd`) and regions.

The setup is designed to be easily scalable, allowing for the addition of new environments, regions, or modules with minimal code duplication.

## Directory Structure

The directory structure is organized as follows:

```
terragrunt/
├── root.hcl
├── eastus/
│   ├── region.hcl
│   ├── dev/
│   │   ├── env.hcl
│   │   └── vnet/
│   │       └── terragrunt.hcl
│   ├── preprd/
│   │   ├── env.hcl
│   │   └── vnet/
│   │       └── terragrunt.hcl
│   └── PRD/
│       ├── env.hcl
│       └── vnet/
│           └── terragrunt.hcl
└── ... (additional regions)
```

- **`root.hcl`**: The root configuration file that is included in all other `terragrunt.hcl` files. It defines the remote state backend and common input variables.
- **`eastus/`**: A directory for a specific Azure region.
- **`region.hcl`**: A file within a region directory that defines the Azure region dynamically based on the directory name.
- **`dev/`, `pre-prd/`, `prd/`**: Directories for different environments.
- **`env.hcl`**: A file within an environment directory that defines the environment name dynamically based on the directory name.
- **`vnet/`**: A directory for a specific Terraform module (in this case, a virtual network).
- **`terragrunt.hcl`**: The Terragrunt configuration file for a specific module in a specific environment and region. It includes the root configuration and provides the necessary inputs to the Terraform module.

## Configuration Files

### `root.hcl`

This is the central configuration file. It sets up the Azure remote state backend and defines global variables that are common across all environments, such as `project_name` and `default_tags`.

### `region.hcl`

This file dynamically determines the Azure region by using the name of the parent directory. This allows for easy addition of new regions without hardcoding the region name.

```hcl
locals {
  region = basename(get_terragrunt_dir())
}
```

### `env.hcl`

Similar to `region.hcl`, this file dynamically determines the environment name from its parent directory's name.

```hcl
locals {
  environment = basename(get_terragrunt_dir())
}
```

### `terragrunt.hcl`

This file is the entry point for deploying a specific module. It includes the `root.hcl` configuration and dynamically reads the region and environment configurations from the parent directories. It then provides the necessary inputs to the underlying Terraform module.

## Deployment Instructions

To deploy the infrastructure, navigate to the directory of the module you want to deploy and run the following commands:

1.  **Initialize Terragrunt:**
    ```sh
    terragrunt init
    ```

2.  **Plan the deployment:**
    ```sh
    terragrunt plan
    ```

3.  **Apply the changes:**
    ```sh
    terragrunt apply
    ```

For example, to deploy the `vnet` in the `dev` environment in the `eastus` region, you would run the commands from the `terragrunt/eastus/dev/vnet/` directory.

## Customization

### Adding a New Environment

To add a new environment (e.g., `staging`), create a new directory at the same level as `dev`, `pre-prd`, and `prd`. Inside the new directory, create an `env.hcl` file and any module directories you need.

### Adding a New Module

To add a new module, create a new directory for the module within each environment directory (e.g., `terragrunt/eastus/dev/new-module/`). Inside the new directory, create a `terragrunt.hcl` file that points to the Terraform module source and provides the necessary inputs.
