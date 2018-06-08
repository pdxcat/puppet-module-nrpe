#
define nrpe::command (
  String $command,
  Enum['present', 'absent'] $ensure            = present,
  String $include_dir                          = $nrpe::include_dir,
  Variant[String, Array[String]] $package_name = $nrpe::package_name,
  String $service_name                         = $nrpe::service_name,
  String $libdir                               = $nrpe::params::libdir,
  String $file_group                           = $nrpe::params::nrpe_files_group,
  Boolean $sudo                                = false,
  String $sudo_user                            = 'root',
) {

  file { "${include_dir}/${title}.cfg":
    ensure  => $ensure,
    content => template('nrpe/command.cfg.erb'),
    owner   => 'root',
    group   => $file_group,
    mode    => '0644',
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

}
