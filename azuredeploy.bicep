param subscriptionId string
param name string
param location string
param hostingPlanName string
param serverFarmResourceGroup string
param alwaysOn bool
param sku string
param skuCode string
param targetWorkerSizeId int
param targetWorkerCount int
param phpVersion string
param netFrameworkVersion string


resource name_resource 'Microsoft.Web/sites@2020-06-01' = {
  name: name
  location: location
  tags: {}
  properties: {
    siteConfig: {
      appSettings: []
      phpVersion: phpVersion
      netFrameworkVersion: netFrameworkVersion
      alwaysOn: alwaysOn
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: true
  }
  dependsOn: [
    hostingPlanName_resource
  ]
}

resource hostingPlanName_resource 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: hostingPlanName
  location: location
  kind: ''
  tags: {}
  properties: {
    targetWorkerSizeId: targetWorkerSizeId
    targetWorkerCount: targetWorkerCount
  }
  sku: {
    tier: sku
    name: skuCode
  }
  dependsOn: []
}