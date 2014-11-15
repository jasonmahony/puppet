class ldapclient {
  $pkgs = [ "nss-pam-ldapd", "openldap", "openldap-clients" ]
  File { owner => root, group => root, mode => 0644 }

  $ldapconfig     = "ldapclient/pam_ldap.conf"
  
  package { $pkgs: 
    ensure => latest,
    before => File[ "/etc/pam_ldap.conf",
      "/etc/nsswitch.conf",
      "/etc/nsswitch.conf",
      "/etc/nslcd.conf",
      '/etc/pam.d/system-auth',
      '/etc/pam.d/password-auth' ] 
  }
  
  file { "/etc/nsswitch.conf":     source => "puppet:///modules/ldapclient/nsswitch.conf" }
  file { "/etc/pam.d/system-auth-ac": source => "puppet:///modules/ldapclient/system-auth-ac" }
  file { "/etc/pam.d/password-auth-ac": source => "puppet:///modules/ldapclient/password-auth-ac" }
  file { "/etc/nslcd.conf": source => 'puppet:///modules/ldapclient/nslcd.conf' }
  file { '/etc/pam.d/system-auth': ensure => 'link', target => '/etc/pam.d/system-auth-ac'}
  file { '/etc/pam.d/password-auth': ensure => 'link', target => '/etc/pam.d/password-auth-ac'}
  
  file {
    "/etc/pam_ldap.conf": 
      content => template($ldapconfig), 
      require => Package[ 
        "nss-pam-ldapd", 
        "openldap" 
      ]
  }
  
  service { 'nslcd': enable => true, ensure => 'running' }
}
