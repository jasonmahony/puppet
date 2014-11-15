class nginx {
  
  file { "/opt/nginx/conf/nginx.conf":
    ensure         => present,
    mode           => 0644,
    template("nginx/nginx_conf") 
    owner          => "root",
    group          => "root"
  }


}
