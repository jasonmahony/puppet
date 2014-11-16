class ntp {
  
  $source = "puppet:///modules/ntp"
  Package { ensure => latest }
  File { ensure => present, owner => root, group => root, mode => 644, require => Package['ntp'], backup => ".puppetbak" }
  
  package { ntp: allow_virtual => false }

  file { '/etc/ntp.conf': source => "$source/ntp.conf" }  
  file { '/etc/ntp/step-tickers': content => template("ntp/steptickers") }
  
  service { ntpd:
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => 'true',
    hasrestart => 'true',
    require    => Package['ntp'],
    subscribe  => File['/etc/ntp.conf'], 
  }
  
}


