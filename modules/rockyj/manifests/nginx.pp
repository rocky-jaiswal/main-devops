class rockyj::nginx {
  
  include stdlib
  include apt

  apt::ppa { "ppa:nginx/stable": 
    before  => Package["nginx"],
  }

  package { "python-software-properties": 
    ensure => latest 
  }

  package { "nginx": 
    ensure => latest,
    require => Package["python-software-properties"]
  }

  service { "nginx": 
    ensure => running,
    require => Package["nginx"]
  }

  file { "logfile1":
    path    => "/var/log/nginx/tweetboardin.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
  }

  file { "tweetboardin-avaliable":
    path    => "/etc/nginx/sites-available/tweetboardin",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/rockyj/static/tweetboardin",
    require => File["logfile1", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "tweetboardin-enabled":
    path    => "/etc/nginx/sites-enabled/tweetboardin",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/tweetboardin",
    require => File["tweetboardin-avaliable"],
  }

}