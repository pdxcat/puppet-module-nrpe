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
class nrpe (
  $allowed_hosts = ['127.0.0.1'],
  $server_address = '0.0.0.0',
  $command_timeout = 60,
  $config          = $nrpe::params::nrpe_config,
  $include_dir     = $nrpe::params::nrpe_include_dir,
  $package_name    = $nrpe::params::nrpe_packages,
  $provider        = $nrpe::params::nrpe_provider,
  $purge           = undef,
  $recurse         = undef,
  $service_name    = $nrpe::params::nrpe_service,
  $dont_blame_nrpe = 0,
) inherits nrpe::params {

  package { $package_name:
    ensure   => installed,
    provider => $provider,
  }

  service { 'nrpe_service':
    ensure    => running,
    name      => $service_name,
    enable    => true,
    require   => Package[$package_name],
    subscribe => File['nrpe_config'],
  }

  file { 'nrpe_config':
    name    => $config,
    content => template('nrpe/nrpe.cfg.erb'),
    require => File['nrpe_include_dir'],
  }

  file { 'nrpe_include_dir':
    ensure  => directory,
    name    => $include_dir,
    purge   => $purge,
    recurse => $recurse,
    require => Package[$package_name],
  }

}
