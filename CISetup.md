GO SETUP ON ACTUAL VM
======================
* IN /etc/fstab

`
	/dev/mapper/vg_jss-LogVol03 /home                   ext4    defaults,nodev,nosuid        1 2
` 


* Add to /etc/sysconfig/iptables

`
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 8153 -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 8154 -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 8069 -j ACCEPT
`

* sudo service iptables restart


* In /etc/profile and Remove the line "umask 027" at the end of the file (If exists)

* reboot


* (run as root)

`
	sudo mkdir /packages
	sudo chown -R user /packages 
	sudo yum install openssh-clients
	(localbox) scp -r /Volumes/TeamShares/Bhamni\ Project/packages/* user@172.18.2.8:/packages/
	cd /packages/localrepo ???
	sudo yum -y localinstall ruby-1.8.7.352-10.el6_4.x86_64.rpm 
	sudo yum -y localinstall augeas-libs-0.9.0-4.el6.x86_64.rpm
	sudo yum -y localinstall facter-1.6.18-3.el6.x86_64.rpm
	sudo yum -y localinstall ruby-augeas-0.4.1-1.el6.x86_64.rpm
	sudo yum -y localinstall ruby-shadow-1.4.1-13.el6.x86_64.rpm
	sudo yum -y localinstall puppet-2.6.18-3.el6.noarch.rpm
	sudo yum -y localinstall git-1.7.1-3.el6_4.1.x86_64.rpm
`

* (in user)

`
	git checkout bahmni-environment (git clone git://github.com/Bhamni/bahmni-environment.git)
	git submodule init
	git submodule update
`
 
(run puppet as root)
`
- puppet apply --graph --graphdir /tmp/puppetGraphs -v -l /tmp/manifest.log --modulepath puppet/modules puppet/manifests/cisetup.pp
- puppet apply -v --debug -l /tmp/manifest.log --modulepath puppet/modules puppet/manifests/cisetup.pp
- puppet apply -v --debug --modulepath puppet/modules puppet/manifests/cisetup.pp
`

(start go)