#
define nrpe::command (
  $command,
  $ensure       = present,
  $mode         = $nrpe::params::nrpe_command_file_mode,
  $include_dir  = $nrpe::include_dir,
  $package_name = $nrpe::package_name,
  $service_name = $nrpe::service_name,
  $libdir       = $nrpe::params::libdir,
  $file_group   = $nrpe::params::nrpe_files_group,
  $sudo         = false,
  $sudo_user    = 'root',
) {

  file { "${include_dir}/${title}.cfg":
    ensure  => $ensure,
    content => template('nrpe/command.cfg.erb'),
    owner   => 'root',
    group   => $file_group,
    mode    => $mode,
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

}
