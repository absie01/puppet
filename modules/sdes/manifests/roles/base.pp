class sdes::roles::base () {
  include sdes::profile::users::init
  include sdes::profiles::sdes_repo::artifactory_repo
}

