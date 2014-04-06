import "configurations/node-configuration"
import "configurations/stack-installers-configuration"
import "configurations/stack-runtime-configuration"
import "configurations/deployment-configuration"
import "configurations/openmrs-versions-configuration.pp"

# pre-condition
# bahmni-stop must have been run before this
node default {
  include bahmni-configuration
  include httpd
  include bahmni-webapps
  include bahmni-ui-apps
  class { 'implementation-config':
    implementationName => "search", require => Class['bahmni-webapps'],
  }
}