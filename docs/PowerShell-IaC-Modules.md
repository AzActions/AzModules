Guidelines for Powershell IaC modules:

## NOTE!
- One parameter file should deploy one resource!
- Chaining done in workflow using input/output.


Suggested folder/file structure:
- ModuleName/
  - SimVer number/
    - deploy.ps1
    - README.md
    - Tests/
    - Scrips/
    - Modules/
    - Parameters/

## Special notes on `deploy.json`:
- Inputs which are supported from the framework:
  - ParameterFilePath,ParametersFolderPath

## What AzModules already does

- Validates JSON of parameterfile, if `$schema` is specified, it also downloads and validates that.


