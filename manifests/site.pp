node puppetmaster.mantech.com {
  include role::master
  file { '/etc/secret_password.txt':
    ensure => file,
    content => lookup('secret_password'),
  }
}
node puppetagent1.mantech.com {
  include role::master
  include role::httpd

  file { '/test.txt':
    ensure  => file,
    content => 'testing testing 123',
  }

  firewalld::custom_service{'puppet':
    short       => 'puppet',
    description => 'Puppet Client access Puppet Server',
    port        => [
      {
  	  'port'     => '8140',
  	  'protocol' => 'tcp',
      },
      {
	  'port'     => '8140',
	  'protocol' => 'udp',
      },
      {
	  'port'     => '443',
	  'protocol' => 'tcp',
      },
      {
	  'port'     => '22',
	  'protocol' => 'tcp',
      },

    ],  
  }
}

node puppetagent2.mantech.com {
  include role::master
#  include role::master_server
}
node default {
  include role::master
}
