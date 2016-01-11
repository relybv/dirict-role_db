# == Class role_db::install
#
# This class is called from role_db for install.
#
class role_db::install {

  package { $::role_db::package_name:
    ensure => present,
  }
}
