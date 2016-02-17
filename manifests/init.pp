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

  include ::profile_mysql
  include ::profile_nfs
}
