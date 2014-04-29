#
class nrpe::params {

  $nrpe_provider = $::osfamily ? {
    'Solaris' => pkgutil,
    default   => undef,
  }

  $nrpe_files_group = $::osfamily ? {
    'FreeBSD' => 'wheel',
    default   => 'root',
  }

  case $::osfamily {
    'Debian':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nagios/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_include_dir = '/etc/nagios/nrpe.d/'
      $nrpe_service     = 'nagios-nrpe-server'
      $nrpe_packages    = [
        'nagios-nrpe-server',
        'nagios-plugins',
      ]
    }
    'Solaris': {
      $libdir           = '/opt/csw/libexec/nagios-plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe.pid'
      $nrpe_config      = '/etc/opt/csw/nrpe.cfg'
      $nrpe_include_dir = '/etc/opt/csw/nrpe.d'
      $nrpe_service     = 'cswnrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios_plugins',
      ]
    }
    'RedHat':  {
      $libdir           = '/usr/lib64/nagios/plugins'
      $nrpe_user        = 'nrpe'
      $nrpe_group       = 'nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_include_dir = '/etc/nrpe.d/'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios-plugins-all',
      ]
    }
    'FreeBSD': {
      $libdir           = '/usr/local/libexec/nagios'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe2/nrpe2.pid'
      $nrpe_config      = '/usr/local/etc/nrpe.cfg'
      $nrpe_include_dir = '/usr/local/etc/nrpe.d'
      $nrpe_service     = 'nrpe2'
      $nrpe_packages    = [
        'nrpe',
        'nagios-plugins',
      ]
    }
    'Suse':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nrpe.cfg'
      $nrpe_include_dir = '/etc/nrpe.d/'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios-plugins-all',
    }
    default:   {
    }
  }

}
