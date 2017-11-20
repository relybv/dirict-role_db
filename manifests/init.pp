# == Class: role_db
#
# Full description of class role_db here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class role_db
{
  # a role includes one or more profiles and at least a 'base' profile
  include ::profile_base
  # include rspec monitor to make rspec acceptance test available to monitor system
  include ::profile_base::rspec_monitor
#  include ::profile_telegraf
#  include ::profile_telegraf::rspec_monitor
#  include ::profile_beats
#  include ::profile_beats::rspec_monitor
  include ::profile_mysql
  include ::profile_mysql::rspec_monitor
  include ::profile_nfs
  include ::profile_nfs::rspec_monitor
#  include ::profile_mcollective
#  include ::profile_mcollective::rspec_monitor
  include ::profile_redis
  include ::profile_redis::rspec_monitor
}
