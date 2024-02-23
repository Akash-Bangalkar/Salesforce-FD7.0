# .forceignore v2
# List files or directories below to ignore them when running force:source:push, force:source:pull, and force:source:status
# More information: https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_exclude_source.htm
#

package.xml

# Documentation
**/*.md

# Include our CMT records, which happens to look similar to documentation...
!base/main/default/customMetadata/**

# Mustache templates
# These contain values (usually sensitive) that need to be templatized
**/*.mustache

# Standard metadata
**/appMenu
**/appSwitcher
**/objectTranslations
**/profiles
*.profile
**/settings
**/authproviders
*.authprovider
*.connectedApp
*.namedCredential
sf_devops_NamedCredentials.permissionSet

# LWC configuration files
**/jsconfig.json
**/.eslintrc.json

# LWC Jest
**/__tests__/**

# Deleted metadata (which still needs to be included in our package due to 2GP metadata management restrictions)
**/deprecated