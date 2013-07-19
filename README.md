mcollective-puppetapply
=======================

trigger the puppet apply to run some puppet code by mco

USAGE
====

    $ mco puppetapply 'exec{"/bin/ls": logoutput => true}'
	
	$ mco puppetapply 'file{"/tmp/test": content => "test"}'
