class network {
 
  case $network_eth0 {
    'w.x.y.z': { $gateway = "w.x.y.a" }  
    'a.b.c.d': { $gateway = "a.b.c.z" }
    default: { $gateway = "x.x.x.x" }
  }
 
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
    path           => ["/usr/bin", "/usr/sbin", "/sbin", "/bin", "/usr/local/bin", "/usr/local/sbin", "/usr/local/rvm/bin/"],
    subscribe      => File["/etc/sysconfig/network-scripts/ifcfg-eth0"],
    refreshonly    => true
  }
}
