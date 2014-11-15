class groups {
  Group { ensure => present, }
  group {'jason': gid => '777' }
}
