import "base.pp"

class app inherits base {
  $prevayler_path = "/var/db/prevayler"
  
  group { 'tomcat': }

  user { 'tomcat':
    require => Group['tomcat'],
  }
  
  package { "tomcat6":
    ensure => present,
    require => User['tomcat']
  }
  
  service { "tomcat6":
    enable => true,
    hasstatus => true,
    hasrestart => true,
    ensure => running,
    require => Package["tomcat6"]
  }
  
  file { "/var/db/prevayler":
    ensure => directory,
    owner => "tomcat",
    group => "tomcat",
    require => Package["tomcat6"]
  }
  
  file { "/etc/tomcat6/tomcat6.conf":
    content => template("tomcat6.conf.erb"),
    owner => "tomcat",
    group => "tomcat",
    require => [ Package["tomcat6"], File["/var/db/prevayler"] ],
    notify => Service['tomcat6']
  }
}

include app
