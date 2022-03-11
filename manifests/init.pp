# @summary Enable automatic upgrades for the system
#
class updates (
  String $bootdelay = '1min',
  String $frequency = '86400'
) {
  case $facts['os']['family'] {
    'Archlinux': { include updates::archlinux }
    'Arch': { include updates::archlinux }
    default: { fail("Module does not support ${facts['os']['family']}") }
  }
}
