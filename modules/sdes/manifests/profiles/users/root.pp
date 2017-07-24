class sdes::profile::users::root (
  $password = undef,
) {
  user {'root':
    ensure => present,
    password => $password,
  }
}