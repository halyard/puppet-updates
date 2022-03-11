# @summary Enable automatic upgrades for the system
#
# @param bootdelay sets how long to wait before first run
# @param frequency sets how often to run updates
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
