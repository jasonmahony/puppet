class apache (
  ### install.pp
  $package = $apache::params::package,
  
  ## config.pp
  $port = $apache::params::port,
  $doc_root = $apache::params::doc_root,
  $server_name = $apache::params::server_name,
  
  ### service.pp
  $service = $apache::params::service,
) 
inherits apache::params {

    anchor { "apache::begin": } ->
    class { "apache::install": } ->
    class { "apache::config": } ->
    class { "apache::service": } ->
    anchor { "apache::end": }

}
