targetScope = 'managementGroup'

resource SubnetPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny VNET Subnet size'
  properties: {
    description: 'Deny VNET subnet size specified in parameters. Policy works for VNET creation and added/updated Subnets for existing VNETs'
    displayName: 'Deny VNET Subnet size'
    mode: 'All'
    metadata: {
      'Category': 'Network'
    }
    parameters: {
      'DeniedSubnetSize': {
        'type': 'String'
        'defaultValue': '/24'
        'metadata': {
            'description': 'The denied Subnet size (eg. /24) VNETs'
            'displayName': 'Deny Subnet size'
        }
    }
    }
    policyRule: {
      'if': {
        'anyof': [
          {
            'allof': [
              {
                'field': 'type'
                'equals': 'Microsoft.Network/virtualNetworks'
              }
              {
                'count': {
                  'field': 'Microsoft.Network/virtualNetworks/subnets[*]'
                  'where': {
                    'field': 'Microsoft.Network/virtualNetworks/subnets[*].addressPrefix'
                    'contains': '[parameters(\'DeniedSubnetSize\')]'
                  }
                }
                'greater': 0
              }
            ]
          }
          {
            'allof': [
              {
                'field': 'type'
                'equals': 'Microsoft.Network/virtualNetworks/subnets'
              }
              {
                'field': 'Microsoft.Network/virtualNetworks/subnets/addressPrefix'
                'contains': '[parameters(\'DeniedSubnetSize\')]'
              }
            ]
          }
        ]
      }
      'then': {
        'effect': 'deny'
      }
    }
  }
}
