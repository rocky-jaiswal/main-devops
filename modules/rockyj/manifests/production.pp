class rockyj::production {

  include rockyj::nginx
  include rockyj::node
  include rockyj::psql
  include rockyj::tbox
  include ufw
  include upstart

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  ufw::allow { "allow-ssh-from-all":
    port => 22,
  }

  ufw::allow { "allow-http-from-all":
    port => 80,
  }

  ufw::allow { "allow-https-from-all":
    port => 443,
  }

  file { "tweetboard":
    path    => "/opt/torquebox/tweetboard",
    ensure  =>  directory,
    owner   => "torquebox",
    group   => "torquebox",
    recurse => true,
    require => User['torquebox']
  }

  upstart::job { 'torquebox_service':
    description    => "This is an example upstart service",
    version        => "3626f2",
    respawn        => true,
    respawn_limit  => '5 10',
    user           => 'torquebox',
    group          => 'torquebox',
    chdir          => '/opt/torquebox/tweetboard/current',
    exec           => "torquebox run",
  }


}
