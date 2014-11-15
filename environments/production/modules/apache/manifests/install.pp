class apache::install {
  
    package { "$::apache::package": ensure => installed, allow_virtual => false }

}