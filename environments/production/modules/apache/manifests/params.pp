class apache::params {
  
  ### install.pp
   $package = "httpd"

   ## config.pp
   $port = "80"
   $doc_root = "/var/www/html"
   $server_name = "centos.localdomain"

   ### service.pp
   $service = "httpd" 
}