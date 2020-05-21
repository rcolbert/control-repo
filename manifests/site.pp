node puppetmaster.mantech.com {
  include role::master
  file { '/etc/secret_password.txt':
    ensure => file,
    content => lookup('secret_password'),
  }
}
node puppetagent1.mantech.com {
  include role::master
  include role::master_server
  file { '/test.txt':
    ensure  => file,
    content => 'testing testing 123',
#  file { '/etc/secret_password.txt':
#    ensure => file,
#    content => hiera('secret_password'),
  }
}
node puppetagent2.mantech.com {
  include role::master
#  file { '/etc/secret_password.txt':
#    ensure => file,
#    content => lookup('secret_password'),
#  }
}
node default {
  include role::master
}
