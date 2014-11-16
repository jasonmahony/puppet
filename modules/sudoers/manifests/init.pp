class sudoers ( $access_level ) {
  
  file { '/etc/sudoers':
      source => "puppet:///modules/sudoers/${access_level}",
      owner  => root,
      group  => root,
      mode   => '0440'
  }
}
