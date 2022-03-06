Modules are atomic units that drive a deployment on a single resource.
In some cases they have child resource or extensions to them that allow for simplifies configuration.
The modules in this repo are **not** ment as solutions and more complex structures.
For more complex deployments, there might be that we add "solutions" or "components" to this repo, but for now its only atomic units!

To be able to support multiple scenarios of usage for modules, we rely on a standard approach to inputs/outputs management which is consistent for the consumers of the modules.

## General guidelines

We try to comply with all code quality and structure best practices from all the IaC languages we use but balance that with consistancy accross languages.
This leads us to land on the following guidelines:

- PascalCase for inputs and outputs
  - Exceptions:
    - File extensions are lowercase.
    - README.md is always in UPPERCASE.
    - @Marius: Abbreviations?
- Approach inputs and outputs as you would with fields/properties of an object.
  - Inputs: Name of an object is not `StorageAccountName` or `ResourceGroupName`, its just `Name`.
  - Outputs: The ouputs of a resource deployment should be the fields of the resource, so that the return of the deployment can be treated as the object representation of that object.
    i.e. $Object.Name and $Object.Location refers to the objects name and location.

## One parameter pr resource/module

- A module should only result in a single instance of that resource.
- Chaining can be done in workflows/pipelines by using input/output, or by making "products" where there are references to modules.

## Products

- Link to products

## Module folder/file structure

| Item          | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| `ModuleName/` | Singular noun describing the object.                         |
| - `vX`        | Folder containing the version of a given module              |
| - Deploy.*    | Deployment file which is called by the action                |
| - Readme.md   | Documentation for the given module                           |
| - Tests/      | Tests that are run when validating the module                |
| - Scripts/    | Scripts that can be called from the `Deploy.*` file.         |
| - Modules/    | Folder to contain modules, extensions, etc.                  |
| - Parameters/ | Parameter files used as example and validation of the module |

## Module versioning

Follow single versioning, where we only care about breaking changes on a module.
Using the same kind of denotation of versioning as GitHub Actions, ´v1´, ´v2´ etc.

## Module parameter description

- Optional, never required for deployment of the resource. It either can be deployed with empty value or has a set default value.
- Conditional, ir required in certain circumstances, depending either on the scope of deployment, or other inputs/parameters that are provided.
- Generated, is generated in the deployment and should not be touched. Especially for ARM deployments, this is usually used for time parameters, using the utcNow() function.
- Required, is required always in the inputs/parameters for the deployment of the resource.

## Module inputs/parameters

Input/Parameters should follow field of the object it is deploying, in the API object declaration or commonly used names of the inputs.
i.e a name of a resource should be `name` and not `\<resourceType\>Name`

Inputs/Parameters use PascalCase for consistancy accross modules.

## Module outputs/returns

Outputs/Return values should return the same set of fields as if it was deployed by hand. name, object/resource ids, properties, etc.
In addition, returns should also reference the parent object(s). So following Object-Oriented Programming you would reference the outputs like:

- resource.name
- resource.id
- resource.parent.resourceGroup.name
- resource.parent.subscription.id

Outputs/Return values use PascalCase for consistancy accross modules.

Example on how this is done on bicep:

``` bicep
output name string = budget.name
output ID string = budget.id
...

output parent object = {
    'resourceGroup': resourceGroup()
    'subscription' : subscription()
    //'managementGroup' : managementGroup()
    //'tenant' : tenant()
}
```

# PowerShell Modules

### Parameter file

- Inputs which are supported from the framework:
  - ParameterFilePath
  - Action

## What AzModules already does

- Validates JSON of parameterfile, if `$schema` is specified, it also downloads and validates that.
