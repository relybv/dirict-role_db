# == Class role_db::params
#
# This class is meant to be called from role_db.
# It sets variables according to platform.
#
class role_db::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'role_db'
      $service_name = 'role_db'
    }
    'RedHat', 'Amazon': {
      $package_name = 'role_db'
      $service_name = 'role_db'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
