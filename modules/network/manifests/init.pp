class network {

  file {'/etc/sysconfig/network-scripts/ifcfg-eth0': 
      ensure => present,
      content => template("network/ifcfg-eth0")  
  }

  file {'/etc/sysconfig/network':
    ensure => present,
    content => template("network/network")  
  }

  exec { "network_restart":
    command        => "/etc/init.d/network restart",
    path           => ["/usr/bin", "/usr/sbin", "/sbin", "/bin", "/usr/local/bin", "/usr/local/sbin" ],
    subscribe      => File["/etc/sysconfig/network-scripts/ifcfg-eth0"],
    refreshonly    => true
  }
}
