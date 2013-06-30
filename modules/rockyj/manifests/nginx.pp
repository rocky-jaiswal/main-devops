class rockyj::nginx {

  package { "nginx": 
    ensure => present 
  }

  service { "nginx": 
    ensure => running 
  }

  file { "logfile1":
    path    => "/var/log/nginx/rockyjin.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
  }

  file { "rockyjin-avaliable":
    path    => "/etc/nginx/sites-available/rockyjin",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/rockyj/static/rockyjin",
    require => File["logfile1", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "rockyjin-enabled":
    path    => "/etc/nginx/sites-enabled/rockyjin",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/rockyjin",
    require => File["rockyjin-avaliable"],
  }

}