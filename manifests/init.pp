# == Class: nrpe
#
# Full description of class nrpe here.
#
# === Parameters
#
# Document parameters here.
#
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# === Examples
#
#
# === Copyright
#
# Copyright 2013 Computer Action Team, unless otherwise noted.
#
class nrpe(
  $allowed_hosts = ['127.0.0.1'],
  $purge         = undef,
  $recurse       = undef,
) inherits nrpe::params {

  package { '$nrpe::params::nrpe_packages':
    ensure   => installed,
    provider => $nrpe::params::nrpe_provider,
  }

  service { 'nrpe_service':
    ensure    => running,
    name      => $nrpe::params::nrpe_service,
    enable    => true,
    require   => Package['nrpe_packages'],
    subscribe => File['nrpe_config'],
  }

  file { 'nrpe_config':
    name    => $nrpe::params::nrpe_config,
    content => template('nrpe/nrpe.cfg.erb'),
    require => File['nrpe_include_dir'],
  }

  file { 'nrpe_include_dir':
    ensure  => directory,
    name    => $nrpe::params::nrpe_include_dir,
    purge   => $purge,
    recurse => $recurse,
    require => Package['nrpe_packages'],
  }

}
