##
# Set up automatic upgrades via pacman
class updates::archlinux (
) {
  $bootdelay = $updates::bootdelay
  $frequency = $updates::frequency

  file { '/etc/systemd/system/automatic-upgrades.service':
    ensure  => file,
    content => template('pacman/automatic-upgrades.service.erb'),
    notify  => Service['automatic-upgrades.timer'],
  }

  file { '/etc/systemd/system/automatic-upgrades.timer':
    ensure  => file,
    content => template('pacman/automatic-upgrades.timer.erb'),
    notify  => Service['automatic-upgrades.timer'],
  }

  service { 'automatic-upgrades.timer':
    ensure  => running,
    enabled => true,
  }
}
