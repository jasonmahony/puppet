node default {

}

node base {
  include motd, ntp, snmp, ldapclient, sudoers, ssh, users, groups, network 
}

node /^app\d{2}.example.com$/ inherits base {
  include nginx
}

node /^pg\{2}.example.com$/ inherits base {
  include postgres
}

node "centos.localdomain" {
  include postgres, sudoers
}