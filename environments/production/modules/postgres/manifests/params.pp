class postgres::params {
  
   ## install.pp
   $postgres_version = "postgresql93"
   $postgres_conf = "/etc/sysconfig/pgsql/postgresql-9.3"
   $postgres_init = "/etc/init.d/postgresql-9.3"

   ## config.pp
   $listen_address = "*"
   $max_connections = "900"
   $wal_level = "minimal"
   $archive_mode = "off"
   $service = "postgresql-9.3"
   
}