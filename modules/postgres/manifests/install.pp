class postgres::install {
	include postgres::params
	$postgres_version = $postgres::params::postgres_version
	$postgres_conf = $postgres::params::postgres_conf
  $postgres_init = $postgres::params::postgres_init
	
	File { ensure => directory, owner => root, group => root, mode => 0755, require => Package["$postgres_version-server"] }
  Package { ensure => installed, allow_virtual => false }
  $source = "puppet:///modules/postgres"
	
	package { "$postgres_version": }
  package { "$postgres_version-server": }
  package { "$postgres_version-libs": }
  package { "$postgres_version-contrib": }
  package { "$postgres_version-devel": }
	
	# set up pgsql directories (puppet won't create intermediate dirs)
	# install allows data and log dirs to be on different partitions (/db and /db/log)
	file { '/db': }
	file { '/db/pgsql': require => File['/db'] }
	file { '/db/pgsql/data': mode => 0700, owner => postgres, group => postgres, require => File['/db/pgsql'] }
	file { '/db/log': owner => postgres, group => postgres, require => File['/db'] }
	# custom sysconfig conf file that init script uses to point data and xlog dirs to different partitions
  file { "$postgres_conf": ensure => present, mode => 0644, source => "$source/conf" }
  file { "$postgres_init": ensure => present, source => "$source/postgres_init" }
}