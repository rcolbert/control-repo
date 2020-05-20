node puppetmaster.mantech.com {
  include role::master
  file { '/etc/secret_password.txt':
    ensure => file,
    content => lookup('secret_password'),
  }
}
node puppetagent1.mantech.com {
  include role::master
  file { '/etc/secret_password.txt':
    ensure => file,
    content => lookup('secret_password'),
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
