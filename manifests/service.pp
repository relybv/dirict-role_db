# == Class role_db::service
#
# This class is meant to be called from role_db.
# It ensure the service is running.
#
class role_db::service {

  service { $::role_db::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
