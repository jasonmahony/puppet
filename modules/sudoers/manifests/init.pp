class sudoers {
  $access_level = "permissive"
  
  file { '/etc/sudoers': 
      source => "puppet:///modules/sudoers/${access_level}", 
      owner => root,
      group => root,
      mode => 0440
  }
}