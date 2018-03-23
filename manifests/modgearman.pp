# install and manage mod_gearman to create worker nodes 

class gearman::modgearman(
  String $ensure          = 'present',
  String $package         = 'mod_gearman',
  String $config_path     = '/etc/mod_gearman',
  String $config_file     = 'worker.conf',
  String $config_template = 'worker.conf.erb',
  Hash $config            = {},
  String $service_name    = 'mod-gearman-worker'
){

  package { $package:
    ensure => $ensure,
  }

  file { $config_file:
    ensure  => $ensure,
    path    => "${config_path}/${config_file}",
    content => template("gearman/${config_template}"),
    require => Package[$package],
  }

  service { $service_name:
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    provider   => 'systemd'
  }
}
