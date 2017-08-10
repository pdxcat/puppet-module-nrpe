NRPE Module for Puppet
======================

[![Puppet Forge](http://img.shields.io/puppetforge/v/pdxcat/nrpe.svg)](https://forge.puppetlabs.com/pdxcat/nrpe) [![Build Status](https://travis-ci.org/pdxcat/puppet-module-nrpe.png?branch=master)](https://travis-ci.org/pdxcat/puppet-module-nrpe)


This module installs and configures nrpe.

Dependencies
------------

### Redhat

 * This module requires the EPEL repositories to be enabled
 * This module currently does not manage the firewall rules
 * This module requires the **puppetlabs/stdlib** module

### Solaris

  * This module depends on OpenCSW packages

Usage
-----

### nrpe

This class installs the packages and configures the daemon.

    class { 'nrpe':
        allowed_hosts => ['127.0.0.1', 'nagios.example.org']
    }


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
