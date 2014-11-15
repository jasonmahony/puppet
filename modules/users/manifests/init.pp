class users {

## Declaring a dependency: we require shared groups from the groups class

  Class[groups] -> Class[users]

## Resource defaults for user accounts

  User { ensure => present, shell => '/bin/bash' }    

  user { 'puppet':
    comment => 'Puppet Service Account',
    home    => '/var/lib/puppet',
    shell => '/sbin/nologin',
    uid     => '52',
    gid     => '52'
  }
  
  user { 'jason':
    comment => 'System Operator',
    home    => '/home/jason',
    uid     => '777',
    gid     => '777',
    groups  => ['jason']
  }

  file { '/home/jason':
    ensure => directory,
    owner   => "jason",
    group   => "jason",
    require => User['jason']
  }
  
}
