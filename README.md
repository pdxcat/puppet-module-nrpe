NRPE Module for Puppet
======================

[![Puppet Forge](http://img.shields.io/puppetforge/v/pdxcat/nrpe.svg)](https://forge.puppetlabs.com/pdxcat/nrpe) [![Build Status](https://travis-ci.org/pdxcat/puppet-module-nrpe.png?branch=master)](https://travis-ci.org/pdxcat/puppet-module-nrpe)


This module installs and configures nrpe.

Dependencies
------------

### Redhat

 * This module requires the EPEL repositories to be enabled
 * This module currently does not manage the firewall rules

### Solaris

  * This module depends on OpenCSW packages

Usage
-----

### nrpe

This class installs the packages and configures the daemon.

    class { 'nrpe':
        allowed_hosts => ['127.0.0.1', 'nagios.example.org']
    }

The nrpe class accepts the following parameters

##### `allowed_hosts`

 Specifies the hosts that NRPE will accept connections from

 *Values: Array of IPs or FQDNs*

 *Default value: `['127.0.0.1']`*

##### `server_address`

 Specifies the IP address that NRPE should bind to incase the system has more than one interface

 *Values: Valid Bindable IP Address*

 *Default value: `0.0.0.0`*

##### `config`

 Specifies the NRPE config file to be written by the nrpe class

 *Values: Any valid filename*

 *Default value: OS Dependent*

##### `include_dir`

 Specifies the NRPE include directory

 *Values: Any valid directory*

 *Default value: OS Dependent*

##### `package_name`

 Specifies the name of the NRPE package to be installed

 *Values: Valid Package Name*

 *Default value: OS Dependent*

##### `manage_package`

 Boolean value, if set to `true` nrpe class will manage the OS Package

 *Values: Boolean (true/false)*

 *Default value: true*

##### `purge`

 Set behavior on nrpe_include_dir, if set to true Puppet will purge any un-managed files within the include dir

 *Values: true,false,undef*

 *Default value: undef*

##### `recurse`

 Set behavior of nrpe_include_dir, if set to true Puppet will recruse through subdirectories within the include dir

 *Values: true,false,undef*

 *Default value: undef*

##### `dont_blame_nrpe`

 If set to 1 NRPE will allow argumnets on check commands, default is to 0. Setting this to one has security implications, and should 
 only be done with due consideration

 *Values: 0 / 1*

 *Default value: 0*
 
##### `log_facility`

 The syslog facility that should be used for logging purposes by NRPE. 

 *Values: Valid log facility*

 *Default value: daemon*

##### `server_port`

 The Port that NRPE should listen on for connections

 *Values: Any valid TCP port number*

 *Default value: 5666*

##### `command_prefix`

 The prefix that should be appended to all NRPE commands, often used to run sudo

 *Values: Any valid shell command/path*

 *Default value: undef*

##### `debug`

 Turn NRPE debugging on or off. 1 for On, 0 for Off

 *Values: 0/1*

 *Default value: 0*

##### `connection_timeout`

 The max number of seconds that NRPE daemon will allow plugins to finih running

 *Values: Integer in seconds*

 *Default value: 300*

##### `allow_bash_command_substitution`

 Allow bash command substitutions, This is a high security risk and should only be enabled with due consideration

 *Values: 0 / 1*

 *Default value: 0*

##### `nrpe_user`

 The user that NRPE should be run as, can be a UID or a username. This is ignored if NRPE is run under xinetd or inetd

 *Values: UID or Username of valid user.*

 *Default value: OS Dependent*

##### `nrpe_group`

 The effective group for NRPE, can be a GID or a group name

 *Values: GID or Groupname of valid user.*

 *Default value: OS Dependent*

##### `nrpe_ssl_dir`

 NRPE SSL directory

 *Values: Any valid directory*

 *Default value: OS dependent*

##### `ssl_cert_file_content`

 A string containing the SSL Certificate

 *Values: A valid SSL Certificate as a string*

 *Default value: undef*

##### `ssl_privatekey_file_content`

 A string containing the SSL Private KEY, this should be an encryped value using EYAML or another method.

 *Values: A valid SSL Private Key as a string*

 *Default value: undef*

##### `ssl_cacert_file_content`

 A string containing the SSL CA Cert file contents

 *Values: A valid SSL CA Cert, and any intermediate certs as a string*

 *Default value: undef*

##### `ssl_version`

 The SSL Version to use

 *Values: A valid SSL Version*

 *Default value: TLSv1.2+*

##### `ssl_ciphers`

 The ciphers that should be allowed by NRPE

 *Values: All valid SSL ciphers*

 *Default value:*
    [
      'DHE-RSA-AES128-GCM-SHA256',
      'DHE-RSA-AES256-GCM-SHA384',
      'DHE-RSA-AES128-SHA',
      'DHE-RSA-AES256-SHA',
      'DHE-RSA-AES128-SHA256',
      'DHE-RSA-AES256-SHA256',
    ]

##### `ssl_client_certs`

 Client certificate behavior of NRPE

 *Values:*
 * 0 = Don't ask
 * 1 = Ask for client cert
 * 2 = Require client cert

 *Default value: 1*

### nrpe::command

This define can be used to add nrpe commands to the include directory for nrpe

    nrpe::command {
        'check_users':
          ensure  => present,
          command => 'check_users -w 5 -c 10';
    }

To purge unmanaged nrpe commands:

    class { 'nrpe':
      allowed_hosts => ['127.0.0.1'],
      purge         => true,
      recurse       => true,
    }

### nrpe::plugin

This define can be used to install nrpe plugins

    nrpe::plugin {
        'check_mem':
          ensure => present,
          source => 'puppet:///files/check_mem',
    }
