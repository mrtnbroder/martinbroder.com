# martinbroder.com Monorepo

This repository contains the source code for my personal website, [martinbroder.com](https://martinbroder.com), along with the infrastructure-as-code to deploy it.

## Tech Stack

The project is a monorepo containing two main parts: the website application and the infrastructure.

### Application (`apps/website`)

*   **Framework**: [SvelteKit](https://kit.svelte.dev/)
*   **Language**: [TypeScript](https://www.typescriptlang.org/)
*   **Styling**: [Tailwind CSS](https://tailwindcss.com/)
*   **State Management**: [XState](https://xstate.js.org/)
*   **Deployment**: Static site hosted on AWS S3.

### Infrastructure (`infrastructure/`)

*   **Provisioning**: [Terraform](https://www.terraform.io/)
*   **Deployment**: [Ansible](https://www.ansible.com/) (for future use)
*   **Cloud Provider**: [Amazon Web Services (AWS)](https://aws.amazon.com/)

## Project Structure

The repository is structured as a monorepo:

```
.
├── apps
│   └── website/      # SvelteKit application
├── infrastructure
│   ├── ansible/      # Ansible playbooks for configuration management
│   └── terraform/    # Terraform code for infrastructure provisioning
└── .github/
    └── workflows/    # GitHub Actions for CI/CD
```

### Terraform Structure

The Terraform code is organized into a bootstrap layer, reusable modules, and distinct environments. This separation ensures that shared resources are managed independently and that environments are kept clean and reproducible.

```
infrastructure/terraform/
├── bootstrap/        # Manages shared, foundational resources (e.g., OAC)
├── environments/
│   ├── develop/      # Configuration for the development environment
│   ├── staging/      # Configuration for the staging environment
│   └── production/   # Configuration for the production environment
├── modules/
│   └── static-website/ # Reusable module for deploying the website
└── terraform.tf      # Global Terraform provider configuration
```

*   `infrastructure/terraform/bootstrap`: This directory contains the root configuration for creating shared resources that are prerequisites for all environments. In this case, it manages the **CloudFront Origin Access Control (OAC)**, which is used by all CloudFront distributions. It has its own separate state file.
*   `infrastructure/terraform/modules/static-website`: A reusable module to create the S3 bucket, CloudFront distribution, and other resources required for a static website.
*   `infrastructure/terraform/environments/`: Contains the configuration for each environment (`develop`, `staging`, `production`). Each environment uses the `static-website` module and retrieves the shared OAC ID from the `bootstrap` state using a `terraform_remote_state` data source.

## Prerequisites

Before you begin, ensure you have the following installed:

*   [Node.js](https://nodejs.org/) (v18 or higher)
*   [Bun](https://bun.sh/)
*   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
*   [AWS CLI](https://aws.amazon.com/cli/)

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/martinbroder/martinbroder.com.git
    cd martinbroder.com
    ```

2.  **Install website dependencies:**

    ```bash
    cd apps/website
    bun install
    ```

3.  **Run the website locally:**

    ```bash
    bun run dev
    ```

    The application will be available at `http://localhost:3000`.

## Deployment Workflow

The deployment process is automated via GitHub Actions, but can also be performed manually.

### Manual Deployment

1.  **Build the website:**

    From the `apps/website` directory, run the build script for the desired environment:

    ```bash
    # For production
    bun run build -- --mode production

    # For development
    bun run build -- --mode dev
    ```

2.  **Deploy to S3:**

    Use the AWS CLI to sync the build output to the corresponding S3 bucket:

    ```bash
    # For production
    aws s3 sync ./build s3://www.martinbroder.com --delete

    # For development
    aws s3 sync ./build s3://dev.martinbroder.com --delete
    ```

### Infrastructure Deployment

The infrastructure is deployed in two stages: bootstrapping the shared resources and then deploying the environment-specific resources.

1.  **Deploy Bootstrap Resources:**

    This step only needs to be run once or when the shared resources need an update.

    ```bash
    cd infrastructure/terraform/bootstrap
    terraform init
    terraform plan
    terraform apply
    ```

2.  **Deploy Environment Resources:**

    To apply changes to a specific environment:

    ```bash
    cd infrastructure/terraform/environments/<environment>
    terraform init
    terraform plan
    terraform apply
    ```
