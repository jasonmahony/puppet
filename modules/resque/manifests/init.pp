class resque ( $rails_env ) {
  
  $source = "puppet:///modules/resque"

  # Creating worker defined type
  define worker ( $resque_queue, $rails_env ) {
     file { "/etc/init/${title}.conf":
     mode    => 644, 
     ensure  => present, 
     content => template('resque/resque-generic.conf.erb') 
     }
  }

  # Call the worker type and pass in parameters
  worker { 'resque-event': resque_queue => "event", rails_env => "${rails_env}" }
  worker { 'resque-signin': resque_queue => "signin", rails_env => "${rails_env}" }

  # Ensure the resque init script and resque gem are installed    
  file { '/etc/init.d/resque': mode => 755, ensure => present, source => "$source/resque-init" }
  package { 'resque': ensure => 'installed', provider => 'gem' }

  # Simple defined type for resque scheduler
  define scheduler ( $rails_env ) {
    file { '/etc/init/resque-scheduler.conf':
    mode => 0644,
    ensure => present,
    template => "resque/resque-scheduler.conf.erb"
    }
  }
  
  # Call the resque scheduler
  scheduler { 'scheduler': rails_env => "${rails_env}"}
  
}
