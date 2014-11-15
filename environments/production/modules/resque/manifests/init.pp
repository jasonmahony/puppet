class resque {

  $source = "puppet:///modules/resque"

  # Passing parameters to a file template
  define worker ( $resque_queue, $rails_env ) {
     file { "/etc/init/${title}.conf":
     mode    => 644, 
     ensure  => present, 
     content => template('resque/resque-generic.conf.erb') 
     }
  }

  # Call the file template with set parameters
  worker { 'resque-event': resque_queue => "event", rails_env => "production" }
  worker { 'resque-signin': resque_queue => "signin", rails_env => "production" }

  # Ensure the resque init script, resque-scheduler upstart and resque gem are installed    
  file { '/etc/init.d/resque': mode => 755, ensure => present, source => "$source/resque-init" }
  file { '/etc/init/resque-scheduler.conf': mode => 0644, ensure => present, source => "$source/resque-scheduler.conf" }
  package { 'resque': ensure => 'installed', provider => 'gem' }

}
