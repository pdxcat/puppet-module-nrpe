#
define nrpe::hiera_plugin (
  $ensure       = present,
  $content_type = undef,
  $content      = undef,
  $source       = undef,
  $mode         = $nrpe::params::nrpe_plugin_file_mode,
  $libdir       = $nrpe::params::libdir,
  $package_name = $nrpe::params::nrpe_packages,
  $file_group   = $nrpe::params::nrpe_files_group,
) {
  case $content_type {
    'template': {
      $real_content = template($content)
    }
    'file': {
      $real_content = file($content)
    }
    default: {
      $real_content = $content
    }
  }

  nrpe::plugin { $title:
    ensure       => $ensure,
    content      => $real_content,
    source       => $source,
    mode         => $mode,
    libdir       => $libdir,
    package_name => $package_name,
    file_group   => $file_group,
  }
}
