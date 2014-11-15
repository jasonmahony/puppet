class snmp {

  $packages = [ 'net-snmp', 'net-snmp-utils', 'net-snmp-libs' ]
  package { $packages: ensure => latest, allow_virtual => false }
  
  service { snmpd:
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => 'true',
    hasrestart => 'true',
    require    => Package['net-snmp'],
    subscribe  => File['/etc/snmp/snmpd.conf', '/etc/sysconfig/snmpd.options']  
  }
  
  file { '/etc/snmp/snmpd.conf':
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/snmp/snmpd.conf',
    require => Package[ $packages ],
  }  

  file { '/etc/sysconfig/snmpd.options':
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/snmp/sysconfig_snmpd.options',
  }  

}
