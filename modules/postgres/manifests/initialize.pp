class postgres::initialize {
  include postgres::params
	$service = $postgres::params::service

  # pgsql_version is custom fact that evaluates to true if db is installed
  unless $pgsql_version { 
    notify { 'init_message': message => 'postgres database not yet initialized; not placing config files until initialized.' }

    # sequence of execs that use a custom pg_xlog location for using custom install
    exec { "delete_default_configs": command => "/bin/rm -f /db/pgsql/data/{postgresql.conf,pg_hba.conf}" }
    exec { 'initialize_database': command => "/sbin/service ${service} initdb", require => Exec["delete_default_configs"] }
    exec { "shutdown_db": command => "/sbin/service ${service} stop", require => Exec["initialize_database"] }
    exec { "move_pg_xlog": command => "/bin/mv /db/pgsql/data/pg_xlog /db/log/pg_xlog", require => Exec["shutdown_db"] } 
  }
}
