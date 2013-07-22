mcollective-puppetapply
=======================

trigger the puppet apply to run some puppet code by mco

USAGE
====

    $ mco puppetapply 'exec{"/bin/ls": logoutput => true}'
	
	$ mco puppetapply 'file{"/tmp/test": content => "test"}' -j
	
INSTALL
====

	$ see [basic plugin install guide](http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/InstalingPlugins)
	$ or if you are using redhat or centos, you can just copy the files to MCollective plugins directory.
	- *MC Servers*: agent/* to /usr/libexec/mcollective/mcollective/agent/
	- *MC Client*: /agent/puppetapply.dll and application/puppetapply.rb to /usr/libexec/mcollective/mcollective/
