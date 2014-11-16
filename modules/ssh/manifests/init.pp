class ssh ( $access_level ){

  package { 'openssh-clients': ensure => latest, allow_virtual => false }
  
  package { 'openssh':
    ensure        => latest,
    notify        => Service['sshd'],
    allow_virtual => false
  }
  
  file { '/etc/ssh/ssh_config':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[ 'openssh-clients' ]
  }
  
  package { 'openssh-server':
    ensure        => latest,
    require       => Package[ 'openssh-clients' ],
    notify        => Service[ 'sshd' ],
    allow_virtual => false
  }

  service { 'sshd':
    ensure     => running,
    name       => sshd,
    enable     => true,
    hasstatus  => true,
    hasrestart => true
  }
  
  file { '/etc/ssh/keys':
    ensure       => present,
    mode         => '0644',
    source       => 'puppet:///modules/ssh/keys',
    recurse      => true,
    recurselimit => 1,
    sourceselect => all,
    purge        => true,
    ignore       => 'root\.pub'
  }
  
  file { '/etc/ssh/sshd_config':
    notify  => Service['sshd'],  # this sets up the relationship
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => Package['openssh-server'],
    source  => "puppet:///modules/ssh/sshd_config/${access_level}",
  }
}
