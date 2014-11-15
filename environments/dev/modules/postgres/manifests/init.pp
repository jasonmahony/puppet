class postgres (

	  ### install
	  $postgres_version = $postgres::params::postgres_version,

    ### config
    $lisen_address = $postgres::params::listen_address,
    $max_connections = $postgres::params::max_connections,
    $wal_level = $postgres::params::wal_level,
    $archive_mode = $postgres::params::archive_mode,
    $archive_command_equals_line = $postgres::params::archive_command_equals_line,
    $service = $postgres::params::service,

) 
inherits postgres::params {

    anchor { "postgres::begin": } ->
    class { "postgres::install": } ->
    class { "postgres::initialize": } ->
    class { "postgres::config": } ->
    anchor { "postgres::end": }

}