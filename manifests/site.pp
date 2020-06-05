
$agent1=" puppetagent1.mantech.com"

node default {
  include role::master
}

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

  file { '/etc/pki/tls/private/puppetagent1.mantech.com.key':
    ensure  => file,
    source => hiera('agent1cert'),
  }

  file { '/etc/pki/tls/certs/puppetagent1.mantech.com.crt':
    ensure  => file,
    source => hiera('agent1cert'),
  }

  file { '/etc/pki/tls/CA/ca.crt':
    ensure  => file,
    source => hiera('cacert'),
  }

  file { '/etc/pki/tls/CA/ca.key':
    ensure  => file,
    source => hiera('cakey'),
  }
#  file { '/test.txt':
#    ensure  => file,
#    content => 'testing testing 123',
#  }

  apache::vhost { 'puppetagent1.mantech.com':
    port          => '80',
    docroot       => '/var/www/',
    docroot_owner => 'apache',
    docroot_group => 'apache',
  }

  apache::vhost { 'puppetagent1.mantech.com':
    port          => '443',
    docroot       => '/var/www/app',
    docroot_owner => 'apache',
    docroot_group => 'apache',
    ssl      => true,
    ssl_cert => '/etc/pki/tls/certs/puppetagent1.mantech.com.cert',
    ssl_key  => '/etc/ssl/etc/pki/tls/private/puppetagent1.mantech.com.key',
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
