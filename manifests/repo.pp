class nrpe::repo {

   $msg_no_repo = "No repo available for ${::osfamily}/${::operatingsystem}"
   case $::osfamily {
    'RedHat': {
      contain '::nrpe::repo::redhat'
    }
    default: {
      fail($msg_no_repo)
    }
  }
}

