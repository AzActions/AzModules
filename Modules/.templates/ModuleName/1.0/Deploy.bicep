targetScope = 'resourceGroup'

@description('Required. The name of the action group.')
param Name string

@description('Optional. Tags of the resource.')
param Tags object = {}

@description('Optional. Location for all resources.')
param Location string = 'global'

resource ResourceA '<resourceType>@<APIVersion>' = {
    name: Name
    location: Location
    tags: Tags
    properties: {
    }
}

output APIVersion string = ResourceA.apiVersion
output ID string = ResourceA.id
output Location string = ResourceA.location
output Name string = ResourceA.name
output Parent object = {
    //'ResourceGroup': resourceGroup()
    //'Subscription' : subscription()
    //'ManagementGroup' : managementGroup()
    //'Tenant' : tenant()
}
output Properties object = ResourceA.properties
output Tags object = ResourceA.tags
output Type string = ResourceA.type
