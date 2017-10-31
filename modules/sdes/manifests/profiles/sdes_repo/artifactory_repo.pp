class sdes::profiles::sdes_repo::artifactory_repo {

    yumrepo { 'sdes_repo':
      enabled => 1,
      baseurl => 'http://10.176.64.11:8097/artifactory/',
      descr => 'HMRC CDG provided artifactory repo',
      gpgcheck => 0,
    }

}