#
define nrpe::plugin (
  $ensure       = present,
  $content      = undef,
  $source       = undef,
  $mode         = $nrpe::params::nrpe_plugin_file_mode,
  $libdir       = $nrpe::params::libdir,
  $package_name = $nrpe::package_name,
  $file_group   = $nrpe::params::nrpe_files_group,
) {
  file { "${libdir}/${title}":
    ensure  => $ensure,
    content => $content,
    source  => $source,
    owner   => 'root',
    group   => $file_group,
    mode    => $mode,
    require => Package[$package_name],
  }
}
