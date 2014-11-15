class ntp {
  
  $source = "puppet:///modules/ntp"
  Package { ensure => latest, allow_virtual => false }
  File { ensure => present, owner => root, group => root, mode => 644, require => Package['ntp'], backup => ".puppetbak" }
  
  package { ntp: }

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


