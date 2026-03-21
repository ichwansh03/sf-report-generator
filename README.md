# sf-report-generator

A Salesforce DX developer tool that automatically generates **SOQL queries** and **REST API endpoint definitions** from Salesforce report configurations — making it easy to integrate Salesforce report data with third-party systems.

---

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Use Cases](#use-cases)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Available Scripts](#available-scripts)
- [Code Quality](#code-quality)
- [Testing](#testing)
- [Deployment](#deployment)
- [Resources](#resources)

---

## Overview

`sf-report-generator` is a Salesforce DX project designed to help developers **automatically generate SOQL queries and REST endpoint definitions** directly from Salesforce reports. Instead of manually writing queries or endpoint specs every time you need to expose report data, this tool derives them from the report itself — saving time and reducing errors.

It is particularly useful when you need to integrate Salesforce report data with external or third-party systems (e.g., ERPs, analytics platforms, middleware tools), as it produces ready-to-use query and endpoint artifacts that can be consumed by those integrations.

- **Primary Language:** Apex (98.5%)
- **Supporting:** JavaScript (LWC)
- **API Version:** 66.0 (Summer '24)
- **Package Directory:** `force-app`

---

## How It Works

1. **Input:** A developer provides a Salesforce report (or report configuration).
2. **SOQL Generation:** The tool inspects the report's fields, filters, and object relationships, then automatically generates the equivalent SOQL query.
3. **REST Endpoint Generation:** Based on the report structure, a corresponding REST API endpoint definition is produced, ready to be called by third-party systems.
4. **Output:** Developers receive generated artifacts (SOQL query + endpoint spec) that they can use directly for integration without manual coding.

---

## Use Cases

- **Third-party integration:** Expose Salesforce report data to external systems (ERP, BI tools, data warehouses) without manually writing SOQL or API specs.
- **API documentation:** Automatically produce endpoint definitions from existing reports for developer handoff.
- **Rapid prototyping:** Quickly generate queries to test data availability before building a full integration.
- **Consistency:** Ensure that SOQL queries and REST endpoints always reflect the current report definition, reducing drift between reports and integrations.

---

## Prerequisites

Before setting up this project, ensure you have the following installed:

- [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli) (`sf` / `sfdx`)
- [Node.js](https://nodejs.org/) (LTS version recommended)
- [VS Code](https://code.visualstudio.com/) with the [Salesforce Extension Pack](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)
- A Salesforce Developer Org or Sandbox with API access enabled

---

## Project Structure

```
sf-report-generator/
├── .husky/                     # Git hooks configuration
├── .vscode/                    # VS Code settings and launch configurations
├── config/                     # Project configuration files
├── force-app/
│   └── main/
│       └── default/            # Salesforce metadata (Apex classes, LWC, etc.)
├── scripts/
│   └── retrieve-apex-class.sh  # Script to retrieve Apex classes from org
├── .forceignore                # Files excluded from Salesforce deployments
├── .prettierrc                 # Prettier formatting configuration
├── eslint.config.js            # ESLint configuration for LWC/Aura
├── jest.config.js              # Jest configuration for unit tests
├── package.json                # Node.js dependencies and npm scripts
└── sfdx-project.json           # Salesforce DX project configuration
```

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/ichwansh03/sf-report-generator.git
cd sf-report-generator
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Authorize a Salesforce Org

```bash
sf org login web --alias my-org
```

### 4. Set the Default Org

```bash
sf config set target-org my-org
```

### 5. Deploy to Your Org

```bash
sf project deploy start --source-dir force-app
```

---

## Development Workflow

### Retrieve Apex Classes from Org

Pull all Apex classes from your connected org:

```bash
npm run retrieve:apex
```

Retrieve a specific Apex class using the SOQL converter script:

```bash
npm run retrieve:soql-converter
```

### Push Changes to Org

```bash
sf project deploy start
```

### Pull Changes from Org

```bash
sf project retrieve start
```

---

## Available Scripts

| Script | Description |
|---|---|
| `npm run lint` | Run ESLint on all Aura and LWC JavaScript files |
| `npm run test` | Run all unit tests |
| `npm run test:unit` | Run LWC unit tests with Jest |
| `npm run test:unit:watch` | Run unit tests in watch mode |
| `npm run test:unit:debug` | Run unit tests in debug mode |
| `npm run test:unit:coverage` | Run unit tests with code coverage report |
| `npm run prettier` | Format all source files using Prettier |
| `npm run prettier:verify` | Check formatting without writing changes |
| `npm run retrieve:apex` | Retrieve all Apex classes from org |
| `npm run retrieve:soql-converter` | Retrieve specific Apex class via SOQL converter |

---

## Code Quality

### ESLint

Linting is configured for Salesforce LWC and Aura components using the `@salesforce/eslint-config-lwc` ruleset.

```bash
npm run lint
```

### Prettier

Prettier auto-formats all supported file types including `.cls`, `.html`, `.js`, `.json`, `.xml`, and more.

```bash
# Format files
npm run prettier

# Verify formatting only
npm run prettier:verify
```

### Husky & lint-staged

Git hooks via **Husky** run `lint-staged` on every commit, which automatically:

- Runs Prettier on all staged files
- Runs ESLint on staged LWC/Aura JavaScript files
- Runs related Jest tests for staged LWC components

---

## Testing

Unit tests use **Jest** with `@salesforce/sfdx-lwc-jest`.

```bash
# Run all tests
npm run test:unit

# Watch mode (during development)
npm run test:unit:watch

# Generate coverage report
npm run test:unit:coverage
```

Test files should live alongside their LWC component under a `__tests__` directory:

```
force-app/main/default/lwc/
└── myComponent/
    ├── myComponent.html
    ├── myComponent.js
    └── __tests__/
        └── myComponent.test.js
```

---

## Deployment

### Deploy to a Sandbox or Production Org

```bash
sf project deploy start --source-dir force-app --target-org <org-alias>
```

### Deploy Specific Apex Class

```bash
sf project deploy start --metadata ApexClass:MyClass --target-org <org-alias>
```

### Validate Only (No Deployment)

```bash
sf project deploy validate --source-dir force-app --target-org <org-alias>
```

---

## Resources

- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
- [Salesforce Reports and Dashboards API via Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_analytics_intro.htm)
- [Apex REST Services](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_rest.htm)
- [LWC Developer Guide](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)
- [Salesforce Extensions for VS Code](https://developer.salesforce.com/tools/vscode/)

---

## Contributing

1. Branch off from `new-enhance`
2. Make your changes, following the ESLint and Prettier conventions enforced by the project
3. Ensure all tests pass: `npm run test`
4. Submit a pull request with a clear description of your changes

---

*Built for Salesforce developers who need fast, reliable integrations without the manual query writing.*