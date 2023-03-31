##
# Set up automatic upgrades via apt
class updates::ubuntu (
) {
  $bootdelay = $updates::bootdelay
  $frequency = $updates::frequency

  file { '/etc/systemd/system/automatic-upgrades.service':
    ensure  => file,
    content => template('updates/ubuntu-automatic-upgrades.service.erb'),
    notify  => Service['automatic-upgrades.timer'],
  }

  file { '/etc/systemd/system/automatic-upgrades.timer':
    ensure  => file,
    content => template('updates/automatic-upgrades.timer.erb'),
    notify  => Service['automatic-upgrades.timer'],
  }

  service { 'automatic-upgrades.timer':
    ensure => running,
    enable => true,
  }
}
