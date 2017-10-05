# Packages for nodes that lack definition, currently has all
# modules for testing purposes

node default {
  Yumrepo <| |> -> Package <| provider != 'rpm' |> #Prioritise resources of type Yumrepo (install these first)
  include ::epel
  include ::java
  include ::docker

  class { 'sensu':
    rabbitmq_password => 'somethingsecure',
    rabbitmq_host => 'sensu-server',
  }
}

node 'rabbit_1', 'rabbit_2' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include ::epel
  include ::erlang

  class {'::rabbitmq':
    config_cluster => true,
    cluster_nodes => ['rabbit_1', 'rabbit_2'],
    cluster_node_type => ram,
    erlang_cookie => 'SECRET',
    cluster_partition_handling => pause_minority,
    wipe_db_on_cookie_change => true,
    admin_enable => true,
  }

  rabbitmq_user {'sdes-admin':
    admin => true,
    password => 'somethingsecure',

  }
}

node 'mongodb_server_1', 'mongodb_server_2', 'mongodb_server_3' {
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class {'::mongodb::client': } ->
  class {'::mongodb::server':
    replset => true,
    replset_config => {'rsmain'=> {ensure => present, members => ['10.180.114.10:27017', '10.180.114.11:27017',
      '10.180.115.10:27017']}}
  }
}

node 'sensu_server' {
  class {'sensu' :
    rabbitmq_password => 'somethingsecure',
    server => true,
    api => true,
  }

  sensu_handler
}