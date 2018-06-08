#
define nrpe::plugin (
  Enum['present', 'absent'] $ensure            = present,
  Optional[String] $content                    = undef,
  Optional[String] $source                     = undef,
  String $mode                                 = $nrpe::params::nrpe_plugin_file_mode,
  String $libdir                               = $nrpe::params::libdir,
  Variant[String, Array[String]] $package_name = $nrpe::params::nrpe_packages,
  String $file_group                           = $nrpe::params::nrpe_files_group,
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
