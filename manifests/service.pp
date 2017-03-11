class nrpe::service inherits nrpe {

  service { $service_name:
    ensure    => running,
    name      => $service_name,
    enable    => true,
    require   => Package[$package_name],
    subscribe => File['nrpe_config'],
  }

}
