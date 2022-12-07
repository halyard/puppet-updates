##
# Set up automatic upgrades via pacman
class updates::archlinux (
) {
  $bootdelay = $updates::bootdelay
  $frequency = $updates::frequency

  file { '/etc/systemd/system/automatic-upgrades.service':
    ensure  => file,
    content => template('updates/automatic-upgrades.service.erb'),
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

  file { '/etc/systemd/system/pacman-cache-clean.service':
    ensure => file,
    source => 'puppet:///modules/updates/pacman-cache-clean.service',
    notify => Service['pacman-cache-clean.timer'],
  }

  file { '/etc/systemd/system/pacman-cache-clean.timer':
    ensure => file,
    source => 'puppet:///modules/updates/pacman-cache-clean.timer',
    notify => Service['pacman-cache-clean.timer'],
  }

  service { 'pacman-cache-clean.timer':
    ensure => running,
    enable => true,
  }
}
