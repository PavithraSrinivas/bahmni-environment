class bahmni_nagios-cfg {
    require nagios

    file { "/etc/nagios/objects":
        ensure      => directory,
        recurse     => true,
        owner       => "${nagios_user}",
        require     => Class["nagios"]
    }

    file { "/etc/nagios/objects/windows.cfg":
        ensure      => absent,
        require     => Class["nagios"]
    }

    file { "/etc/nagios/objects/printer.cfg":
        ensure      => absent,
        require     => Class["nagios"]
    }

    file { "/etc/nagios/objects/switch.cfg":
        ensure      => absent,
        require     => Class["nagios"]
    }

    file { "/etc/nagios/objects/localhost.cfg":
        content     => template("bahmni_nagios/localhost-${implementation_name}.cfg"),
        ensure      => present,
        owner       => "${nagios_user}",
        notify      => Service["nagios"],
        require     => File["/etc/nagios/objects"],
    }
    
    file { "/etc/nagios/objects/commands.cfg":
        content     => template("bahmni_nagios/commands.cfg"),
        ensure      => present,
        owner       => "${nagios_user}",
        notify      => Service["nagios"],
        require     => File["/etc/nagios/objects"]
    }

    file { "/etc/nagios/objects/contacts.cfg":
        content     => template("bahmni_nagios/contacts.cfg"),
        ensure      => present,
        owner       => "${nagios_user}",
        notify      => Service["nagios"],
        require     => File["/etc/nagios/objects"]
    }

    file { "/etc/nagios/objects/templates.cfg":
        content     => template("bahmni_nagios/templates.cfg"),
        ensure      => present,
        owner       => "${nagios_user}",
        notify      => Service["nagios"],
        require     => File["/etc/nagios/objects"]
    }

    file { "/etc/nagios/objects/timeperiods.cfg":
        content     => template("bahmni_nagios/timeperiods.cfg"),
        ensure      => present,
        owner       => "${nagios_user}",
        notify      => Service["nagios"],
        require     => File["/etc/nagios/objects"]
    }
}


class bahmni_nagios-server {
    require nagios
    require bahmni_nagios-cfg

    exec { "setup_object_files_in_config" :
        command => "sed -i 's/^cfg_file\s*=.*$//g' /etc/nagios/nagios.cfg && find /etc/nagios/objects -name \\*cfg | sed 's/\\(.*\\)/cfg_file=\\1/g' >> /etc/nagios/nagios.cfg",
        path    => "${os_path}",
        require => Class["bahmni_nagios-cfg"],
        notify  => Service["nagios"],
    }

    package { "perl-Time-HiRes":
        ensure => installed,
    }

    service { "nagios":
        enable => true,
        ensure => running
    }
}

class bahmni_nagios-client {
    require nagios

    service { "nagios":
        enable => false,
        ensure => stopped
    }
}

class bahmni_nagios {
    case $nagios_machine_type {
        "server": {
            require bahmni_nagios-server
        }
        "client": {
            require bahmni_nagios-client 
        }
    }
}