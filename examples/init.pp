class { 'nrpe':
  allowed_hosts   => ['127.0.0.1', 'nagios.example.com'],
  command_timeout => 123,
}
