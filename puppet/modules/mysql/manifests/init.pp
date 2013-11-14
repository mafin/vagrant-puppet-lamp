class mysql 
{
    $mysqlPassword = "123456789"
 
    package 
    { 
        "mysql-server":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }

    exec {
        "set-mysql-password":
            unless  => "mysql -uroot -p$mysqlPassword",
            command => "mysqladmin -uroot password $mysqlPassword",
            require => Service["mysql"],
    }

    exec {
        "load-schema-world":
            #path    => "/usr/bin:/usr/sbin:/bin",
            command => "mysql -u root -p$mysqlPassword < /vagrant/puppet/scripts/mysql/world.sql",
            unless  => "mysql -u root -p$mysqlPassword -e \"use world\"",
            require => Service['mysql'],
    }
}
