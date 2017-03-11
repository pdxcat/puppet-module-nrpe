class nrpe::install inherits nrpe {
  if $manage_package {

    if $nrpe_repo {

      package { $nrpe_repo:
        ensure   => installed,
      }
    }

    package { $package_name:
      ensure   => installed,
      provider => $provider,
    }
  }
}
