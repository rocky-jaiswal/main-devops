class rockyj::psql {

  include psql

  class { 'postgresql::server':
    config_hash => {
      'ip_mask_deny_postgres_user' => '0.0.0.0/32',
      'ip_mask_allow_all_users'    => '0.0.0.0/0',
      'listen_addresses'           => '*',
      'postgres_password'          => 'p@ssword121',
    },
  }

  postgresql::db { 'app_prod':
    user     => 'app_prod',
    password => 'p@ssword1221'
  }

}