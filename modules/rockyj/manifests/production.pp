class rockyj::production {

  include rockyj::nginx
  include rockyj::psql
  include rockyj::tbox

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  user { "deploy":
    comment => "Deploy User",
    home    => "/home/deploy",
    ensure  => present,
    gid     => "www-data",
    shell   => "/bin/bash",
    managehome   => true,
  }

  file { "home":
    path    => "/home/deploy",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    require => User["deploy"],
  }

  file { "tweetboard":
    path    => "/home/deploy/tweetboard",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    recurse => true,
    require => File["home"],
  }

}
