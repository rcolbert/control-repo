class role::httpd {
  include profile::httpd
  include profile::firewalld
}
