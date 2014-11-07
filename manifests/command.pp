#
define nrpe::command (
  $command,
  $ensure       = present,
  $include_dir  = $nrpe::params::nrpe_include_dir,
  $libdir       = $nrpe::params::libdir,
  $package_name = $nrpe::params::nrpe_packages,
  $service_name = $nrpe::params::nrpe_service,
  $file_group   = $nrpe::params::nrpe_files_group,
) {

  file { "${include_dir}/${title}.cfg":
    ensure  => $ensure,
    content => template('nrpe/command.cfg.erb'),
    owner   => root,
    group   => $file_group,
    mode    => '0644',
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

}
