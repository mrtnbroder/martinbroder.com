# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Structure

This is a monorepo containing Martin Broder's personal website and its infrastructure:

- `apps/website/` - SvelteKit application (TypeScript, Tailwind CSS, XState)
- `infrastructure/terraform/` - Infrastructure as Code for AWS deployment
- `infrastructure/ansible/` - Configuration management (future use)

The website uses SvelteKit with Svelte 5 (runes mode), TypeScript, Tailwind CSS 4, and XState for state management. It's deployed as a static site on AWS S3 with CloudFront distribution.

## Development Commands

All development commands should be run from the `apps/website/` directory:

```bash
cd apps/website
```

### Core Development
- `bun install` - Install dependencies
- `bun run dev` - Start development server (http://localhost:3000)
- `bun run build` - Build for production
- `bun run build -- --mode dev` - Build for development environment
- `bun run build -- --mode production` - Build for production environment
- `bun run preview` - Preview production build locally

### Code Quality
- `bun run lint` - Run prettier check and eslint
- `bun run format` - Format code with prettier
- `bun run check` - Run svelte-check for type checking
- `bun run check:watch` - Run svelte-check in watch mode

### Deployment
- `bun run sync:dev` - Build and deploy to development S3 bucket
- `bun run sync:production` - Build and deploy to production S3 bucket
- `bun run s3-deploy:dev` - Deploy build to dev.martinbroder.com S3 bucket
- `bun run s3-deploy:production` - Deploy build to www.martinbroder.com S3 bucket

## Key Technologies and Patterns

### Frontend Framework
- **SvelteKit** with static adapter for SSG
- **Svelte 5** with runes mode enabled (modern reactive primitives)
- **TypeScript** for type safety
- **Tailwind CSS 4** for styling with PostCSS integration

### State Management
- **XState** for complex state logic (see `apps/website/src/routes/about/machine.ts`)
- Uses XState v5 with setup() pattern for machine definitions

### Effect-TS Integration
- Uses Effect-TS for functional programming patterns
- HTTP client implementations with schema validation
- Example: `apps/website/src/lib/utils/getDadJoke.ts` shows Effect-based API calls

### Component Architecture
- Components in `apps/website/src/lib/components/`
- Icons in `apps/website/src/lib/components/icons/`
- Utilities in `apps/website/src/lib/utils/`
- Actions (Svelte actions) in `apps/website/src/lib/actions/`

## Infrastructure

### Terraform Structure
The infrastructure follows a layered approach:

1. **Bootstrap layer** (`infrastructure/terraform/bootstrap/`) - Creates shared resources like CloudFront OAC
2. **Environment layers** (`infrastructure/terraform/environments/`) - Environment-specific configurations
3. **Modules** (`infrastructure/terraform/modules/static-website/`) - Reusable infrastructure components

### Deployment Process
1. Bootstrap resources: `cd infrastructure/terraform/bootstrap && terraform init && terraform apply`
2. Environment deployment: `cd infrastructure/terraform/environments/<env> && terraform init && terraform apply`
3. Website deployment: Use sync commands from apps/website directory

## Important Notes

- The project uses **Bun** as the package manager and runtime
- Prettier and ESLint are configured with specific rules for Svelte and TypeScript
- The build process creates a static site suitable for S3 hosting
- All environments (dev, staging, production) use separate S3 buckets and CloudFront distributions
- The codebase follows functional programming patterns with Effect-TS integration