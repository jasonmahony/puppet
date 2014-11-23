==========
Open-Source Puppet Infrastructure Using Hiera
==========

A Puppet layout using Hiera supporting Puppet Dashboard.
Supports RHEL/CentOS 6 with Puppet v3.7.3.
Assumes install directory is /etc/puppet and FQDN of the puppetmaster is puppetmaster.localdomain.


To install:
```
1) Set-up puppetmaster according to Puppet-Labs doc
  https://docs.puppetlabs.com/guides/install_puppet/install_el.html
2) Install the puppet agent on the master (optional)
3) Pull down this repo into /etc/puppet on your puppetmaster
4) Use puppet.conf.agent on your puppet nodes. File should be /etc/puppet/puppet.conf
```
Puppet-Dashboard
```
5) On puppetmaster node (or separate node) install puppet-dashboard RPM and follow guide below
  https://docs.puppetlabs.com/dashboard/manual/1.2/bootstrapping.html
```
------------
Jason Mahony
