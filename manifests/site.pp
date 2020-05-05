node puppet1agent.mantech.com {
  include role::master
  file { '/etc/secret_password.txt':
    ensure => file,
    content => lookup('secret_password'),
  }
}
