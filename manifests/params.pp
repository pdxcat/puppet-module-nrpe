#
class nrpe::params {

  $nrpe_provider = $::osfamily ? {
    'Solaris' => pkgutil,
    default   => undef,
  }

  $nrpe_files_group = $::osfamily ? {
    /(Free|Open)BSD/ => 'wheel',
    default   => 'root',
  }

  $nrpe_plugin_file_mode = '0755'

  case $::osfamily {
    'Debian':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nagios/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nagios/nrpe.d'
      $nrpe_service     = 'nagios-nrpe-server'
      $nrpe_packages    = [
        'nagios-nrpe-server',
        'nagios-plugins',
      ]
    }
    'Archlinux':  {
      $libdir           = '/usr/lib/monitoring-plugins'
      $nrpe_user        = 'nrpe'
      $nrpe_group       = 'nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nrpe/nrpe.cfg'
      $nrpe_include_dir = '/etc/nrpe/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'monitoring-plugins',
      ]
    }
    'Solaris': {
      $libdir           = '/opt/csw/libexec/nagios-plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe.pid'
      $nrpe_config      = '/etc/opt/csw/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/opt/csw/nrpe-ssl'
      $nrpe_include_dir = '/etc/opt/csw/nrpe.d'
      $nrpe_service     = 'cswnrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios_plugins',
      ]
    }
    'RedHat':  {
      $libdir           = $::architecture ? {
        /x86_64/ => '/usr/lib64/nagios/plugins',
        default  => '/usr/lib/nagios/plugins',
      }
      $nrpe_user        = 'nrpe'
      $nrpe_group       = 'nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nrpe.d'
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
      $nrpe_ssl_dir     = '/usr/local/etc/nrpe-ssl'
      $nrpe_include_dir = '/usr/local/etc/nrpe.d'
      $nrpe_service     = 'nrpe2'
      $nrpe_packages    = [
        'net-mgmt/nrpe',
        'net-mgmt/nagios-plugins',
      ]
    }
    'OpenBSD': {
      $libdir           = '/usr/local/libexec/nagios'
      $nrpe_user        = '_nrpe'
      $nrpe_group       = '_nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nrpe-ssl'
      $nrpe_include_dir = '/etc/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'monitoring-plugins',
      ]
    }
    'Suse':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_service     = 'nrpe'
      case $::operatingsystem {
        'SLES': {
          $nrpe_config      = '/etc/nagios/nrpe.cfg'
          $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
          $nrpe_include_dir = '/etc/nagios/nrpe.d'
          $nrpe_packages    = [
            'nagios-nrpe',
            'nagios-plugins',
            'nagios-plugins-nrpe',
          ]
        }
        default:   {
          $nrpe_config      = '/etc/nrpe.cfg'
          $nrpe_ssl_dir     = '/etc/nrpe-ssl'
          $nrpe_include_dir = '/etc/nrpe.d'
          $nrpe_packages    = [
            'nrpe',
            'nagios-plugins-all',
          ]
        }
      }
    }
    'Gentoo':  {
      $libdir           = $::architecture ? {
        /x86_64/ => '/usr/lib64/nagios/plugins',
        default  => '/usr/lib/nagios/plugins',
      }
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nagios/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'net-analyzer/nrpe',
        'net-analyzer/nagios-plugins',
      ]
    }
    default:   {
    }
  }

  $dont_blame_nrpe                 = 0
  $allow_bash_command_substitution = undef # not in very old NRPE
  $log_facility                    = 'daemon'
  $server_port                     = 5666
  $command_prefix                  = undef
  $debug                           = 0
  $connection_timeout              = 300

  $ssl_version                 = 'TLSv1.2+'
  $ssl_ciphers                 = [
    'DHE-RSA-AES128-GCM-SHA256',
    'DHE-RSA-AES256-GCM-SHA384',
    'DHE-RSA-AES128-SHA',
    'DHE-RSA-AES256-SHA',
    'DHE-RSA-AES128-SHA256',
    'DHE-RSA-AES256-SHA256',
  ]
  $ssl_client_certs            = 1
}
