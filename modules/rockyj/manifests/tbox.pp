class rockyj::tbox {

  package { "openjdk-7-jdk": 
    ensure => latest,
    before => Exec['install_torquebox']
  }

  class { 'torquebox':
    version         => '2.3.2',
    add_to_path     => true,
  }

}