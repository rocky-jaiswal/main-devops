class rockyj::production {

  include rockyj::nginx
  include rockyj::node
  include rockyj::psql
  include rockyj::tbox

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  file { "tweetboard":
    path    => "/opt/torquebox/tweetboard",
    ensure  =>  directory,
    owner   => "torquebox",
    group   => "torquebox",
    recurse => true,
    require => User['torquebox']
  }

}
