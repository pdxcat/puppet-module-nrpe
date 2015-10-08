#
define nrpe::plugin (
  $ensure       = present,
  $content      = undef,
  $source       = undef,
  $mode         = $nrpe::params::nrpe_plugin_file_mode,
  $libdir       = $nrpe::params::libdir,
  $package_name = $nrpe::params::nrpe_packages,
  $file_group   = $nrpe::params::nrpe_files_group,
) {
  if ($content == undef and $source == undef) {
    fail("nrpe::plugin[$title]: Either \$content or \$source must be defined!")
  }
  if ($content != undef and $source != undef) {
    fail("nrpe::plugin[$title]: \$content and \$source must not both be defined!")
  }
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
