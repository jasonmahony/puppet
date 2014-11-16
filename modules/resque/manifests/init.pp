class resque ( $rails_env ) {
  
  $source = "puppet:///modules/resque"
  File { ensure => present, mode => 0644 }

  # Creating worker defined type
  define worker ( $resque_queue, $rails_env ) {
     file { "/etc/init/${title}.conf": content => template('resque/resque-generic.conf.erb') }
  }

  # Call the worker type
  worker { 'resque-event': resque_queue => "event", rails_env => "${rails_env}" }
  worker { 'resque-signin': resque_queue => "signin", rails_env => "${rails_env}" }

  # Ensure the resque init script and resque gem are installed    
  file { '/etc/init.d/resque': mode => 755, ensure => present, source => "$source/resque-init" }
  package { 'resque': ensure => 'installed', provider => 'gem' }

  # Use a template that takes the $rails_env variable
  file { '/etc/init/resque-scheduler.conf': content => template("resque/resque-scheduler.conf.erb") }

}
