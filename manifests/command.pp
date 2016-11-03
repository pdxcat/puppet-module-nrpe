#
define nrpe::command (
  $command,
  $ensure         = present,
  $include_dir    = $nrpe::include_dir,
  $package_name   = $nrpe::package_name,
  $service_name   = $nrpe::service_name,
  $libdir         = $nrpe::params::libdir,
  $nrpe_user      = $nrpe::params::nrpe_user,
  $file_group     = $nrpe::params::nrpe_files_group,
  $manage_sudoers = $nrpe::manage_sudoers,
  $sudoers        = $nrpe::sudoers,
  $sudo           = $nrpe::sudo,
  $sudo_user      = $nrpe::sudo_user,
) {

  if ($command =~ /^\//) {
    $command_real = $command
  } else {
    $command_real = "${libdir}/${command}"
  }

  if ($manage_sudoers == true and $sudo == true) {
    $context = "/files/${sudoers}"
    $spec = "spec[user = '${nrpe_user}']"

    if ($ensure == present) {
      if !defined(File[$sudoers]) {
        exec { $sudoers:
          path    => ['/bin', '/usr/bin', '/usr/local/bin' ],
          command => "touch $sudoers",
          creates => $sudoers,
        } ->
        file { $sudoers:
          ensure => file,
          owner  => 'root',
          group  => 0,
          mode   => '0440',
        }
      }
      augeas { "${name}_${command}_${nrpe_user}_${sudo_user}":
        context => $context,
        changes => [
          "set ${spec}/user ${nrpe_user}",
          "set ${spec}/host_group/host ALL",
          "set ${spec}/host_group/command[last()+1] '${command_real}'",
          "set ${spec}/host_group/command[last()]/runas_user ${sudo_user}",
          "set ${spec}/host_group/command[last()]/tag NOPASSWD",
        ],
        onlyif  => "match ${context}/${spec}/host_group/command[. = '${command_real}'][runas_user = '${sudo_user}'][tag = 'NOPASSWD'] size == 0",
        lens    => 'Sudoers.lns',
        incl    => $sudoers,
      }
    } elsif ($ensure == absent) {
      augeas { "${name}_${command}_${nrpe_user}":
        context => $context,
        changes => [
          "rm ${spec}",
        ],
        onlyif  => "match ${context}/${spec}/host_group/command size == 1",
        lens    => 'Sudoers.lns',
        incl    => $sudoers,
      } ->
      augeas { "${name}_${command}_${nrpe_user}_${sudo_user}":
        context => $context,
        changes => [
          "rm ${spec}/host_group/command[. = '${command_real}'][runas_user = '${sudo_user}'][tag = 'NOPASSWD']",
        ],
        onlyif  => "match ${context}/${spec}/host_group/command size > 1",
        lens    => 'Sudoers.lns',
        incl    => $sudoers,
      }
    }
  }

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
