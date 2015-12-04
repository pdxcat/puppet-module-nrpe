#
define nrpe::plugin (
  $ensure       = present,
  $content      = undef,
  $source       = undef,
  $mode         = $nrpe::params::nrpe_plugin_file_mode,
  $libdir       = $nrpe::params::libdir,
  $package_name = $nrpe::params::nrpe_packages,
  $file_group   = $nrpe::params::nrpe_files_group,
  $selrange     = undef,
  $selrole      = undef,
  $seltype      = undef,
  $seluser      = undef,
 
) {
  file { "${libdir}/${title}":
    ensure   => $ensure,
    content  => $content,
    source   => $source,
    owner    => 'root',
    group    => $file_group,
    mode     => $mode,
    require  => Package[$package_name],
    selrange => $selrange,
    selrole  => $selrole,
    seltype  => $seltype,
    seluser  => $seluser,
  }
}
