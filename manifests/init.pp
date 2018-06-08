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
  Array[String] $allowed_hosts                      = ['127.0.0.1'],
  String $server_address                            = '0.0.0.0',
  Integer $command_timeout                          = 60,
  String $config                                    = $nrpe::params::nrpe_config,
  String $include_dir                               = $nrpe::params::nrpe_include_dir,
  Variant[String, Array[String]] $package_name      = $nrpe::params::nrpe_packages,
  Optional[String] $provider                        = $nrpe::params::nrpe_provider,
  Boolean $manage_package                           = true,
  Optional[Boolean] $purge                          = undef,
  Optional[Boolean] $recurse                        = undef,
  String $service_name                              = $nrpe::params::nrpe_service,
  Integer $dont_blame_nrpe                          = $nrpe::params::dont_blame_nrpe,
  String $log_facility                              = $nrpe::params::log_facility,
  Integer $server_port                              = $nrpe::params::server_port,
  Optional[String] $command_prefix                  = $nrpe::params::command_prefix,
  Integer $debug                                    = $nrpe::params::debug,
  Integer $connection_timeout                       = $nrpe::params::connection_timeout,
  Optional[Integer]$allow_bash_command_substitution = $nrpe::params::allow_bash_command_substitution,
  String $nrpe_user                                 = $nrpe::params::nrpe_user,
  String $nrpe_group                                = $nrpe::params::nrpe_group,
  String $nrpe_pid_file                             = $nrpe::params::nrpe_pid_file,
  String $nrpe_ssl_dir                              = $nrpe::params::nrpe_ssl_dir,
  Optional[String] $ssl_cert_file_content           = undef,
  Optional[String] $ssl_privatekey_file_content     = undef,
  Optional[String] $ssl_cacert_file_content         = undef,
  String $ssl_version                               = $nrpe::params::ssl_version,
  Array[String] $ssl_ciphers                        = $nrpe::params::ssl_ciphers,
  Integer $ssl_client_certs                         = $nrpe::params::ssl_client_certs,
  Boolean $ssl_log_startup_params                   = false,
  Boolean $ssl_log_remote_ip                        = false,
  Boolean $ssl_log_protocol_version                 = false,
  Boolean $ssl_log_cipher                           = false,
  Boolean $ssl_log_client_cert                      = false,
  Boolean $ssl_log_client_cert_details              = false,
) inherits nrpe::params {

  if $manage_package {
    package { $package_name:
      ensure   => installed,
      provider => $provider,
    }
  }

  service { $service_name:
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

  if $ssl_cert_file_content {
    file { $nrpe_ssl_dir:
      ensure => directory,
      owner  => 'root',
      group  => $nrpe_group,
      mode   => '0750',
    }
    file { "${nrpe_ssl_dir}/ca-cert.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe_group,
      mode    => '0640',
      content => $ssl_cacert_file_content,
      notify  => Service[$service_name],
    }
    file { "${nrpe_ssl_dir}/nrpe-cert.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe_group,
      mode    => '0640',
      content => $ssl_cert_file_content,
      notify  => Service[$service_name],
    }
    file { "${nrpe_ssl_dir}/nrpe-key.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe_group,
      mode    => '0640',
      content => $ssl_privatekey_file_content,
      notify  => Service[$service_name],
    }
  }

  file { 'nrpe_include_dir':
    ensure  => directory,
    name    => $include_dir,
    purge   => $purge,
    recurse => $recurse,
    require => Package[$package_name],
  }

}
