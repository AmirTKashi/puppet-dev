# @summary
#   Install a package
#
# This is intended to be invoked automatically by
# [`ud::profile::base`](#udprofilebase) based on the YAML array
# [`ud::packages`](README.md#udpackages).  You should not need to use
# this defined type directly.
#
# @param name
#   Package name
#
# @param ensure
#   Desired state ('present' or 'absent')
#
define ud::package (
  String $ensure = 'present',
)
{

  # Install package, if not already managed elsewhere
  #
  if ! defined(Package[$name]) {
    package { $name:
      ensure => $ensure,
    }
  }

}
