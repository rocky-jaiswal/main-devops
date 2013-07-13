# Class: torquebox
#
#   This class handles the installation and management of the TorqueBox application server.
#
class torquebox (
  $version          = '2.3.2',
  $add_to_path      = true
) {
  
  case $::osfamily {
    Debian: {
      $supported = true
    }
    default: {
      fail("The torquebox module is not supported on ${::osfamily} based systems")
    }
  }

  $torquebox_package = "torquebox-dist-${version}-bin.zip"
  $torquebox_source = "http://torquebox.org/release/org/torquebox/torquebox-dist/${version}/${torquebox_package}"

  package { 'unzip':
    ensure => true
  }

  file { ['/opt/torquebox']:
    ensure => 'directory'
  }

  group { 'torquebox':
    ensure => 'present',
    before => Exec['install_torquebox']
  }

  user { 'torquebox':
    ensure  => 'present',
    gid     => 'torquebox',
    home    => '/opt/torquebox',
    require => Group['torquebox']
  }

  exec { 'install_torquebox':
    cwd       => '/home/rockyj',
    command   => "/usr/bin/wget ${torquebox_source} /home/rockyj &&
                  /usr/bin/unzip ${torquebox_package} &&
                  /bin/mv torquebox-${version} /opt/torquebox/${version}",
    creates   => '/opt/torquebox/current/jboss/bin/standalone.sh',
    logoutput => 'on_failure',
    timeout   => 0,
    require   => [Package['unzip'], File['/opt/torquebox'], User['torquebox']]
  }

  file { '/etc/profile.d/torquebox_vars.sh':
    ensure  => 'present',
    source  => 'puppet:///modules/torquebox/torquebox_vars.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Exec['install_torquebox'],
    before  => [ File['/etc/init/torquebox.conf'], Service['torquebox'] ]
  }

  if $add_to_path == true {
    file { '/etc/profile.d/torquebox_path.sh':
      ensure  => 'present',
      source  => 'puppet:///modules/torquebox/torquebox_path.sh',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File['/etc/profile.d/torquebox_vars.sh']
    }
  }

  file { '/etc/init/torquebox.conf':
    ensure  => 'present',
    source  => 'puppet:///modules/torquebox/upstart.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Exec['install_torquebox']
  }

  service { 'torquebox':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/init/torquebox.conf']
  }
}
