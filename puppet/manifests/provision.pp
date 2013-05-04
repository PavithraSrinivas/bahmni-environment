import "configurations/node-configuration"
import "configurations/stack-installers-configuration"
import "configurations/stack-runtime-configuration"

node default {
	# include host
	# include tools
	# include java
	# include mysql
	# include mysqlserver
	# class {users : userName => "${bahmni_user}", password_hash => "${bahmni_user_password_hash}"}
	# include tomcat
	# include openmrs
 #  include jasperserver
 #  include tomcat-runtime
 	include python-platform
 	# include postgresql
	include openerp
}