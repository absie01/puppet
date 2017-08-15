# Packages for nodes that lack definition, currently has all
# modules for testing purposes

node default {
  Yumrepo <| |> -> Package <| provider != 'rpm' |> #Prioritise resources of type Yumrepo (install these first)
  include ::epel
  include ::clamav
  include ::git
  include ::java
  include ::docker
  include ::rabbitmq
  include ::mongodb::server
  include ::mongodb::client
}

node 'bastion' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include sdes::roles::base
}

node 'rabbit-1' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include ::epel
  include ::rabbitmq

  class {'::rabbitmq':
    config_cluster => true,
    cluster_nodes => ['rabbit1', 'rabbit2'],
    cluster_node_type => ram,
    erlang_cookie => 'SECRET',
    cluster_partition_handling => pause_minority,
    wipe_db_on_cookie_change => true,
  }
}

node 'rabbit-2' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include ::epel
  include ::rabbitmq

  class {'::rabbitmq':
    config_cluster => true,
    cluster_nodes => ['rabbit1', 'rabbit2'],
    cluster_node_type => ram,
    erlang_cookie => 'SECRET',
    cluster_partition_handling => pause_minority,
    wipe_db_on_cookie_change => true,
  }
}

node 'mongodb_server_1', 'mongodb_server_2', 'mongodb_server_3' {
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class {'::mongodb::client': } ->
  class {'::mongodb::server':
    replset => true,
    replset_config => {'rsmain'=> {ensure => present, members => ['mongodb_server_1:27017', 'mongodb_server_2:27017',
      'mongodb_server_3:27017']}}
  }
}