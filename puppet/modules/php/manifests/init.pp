class php 
{
    $packages = [
        "php5", 
        "php5-cli", 
        "php5-mysql", 
        "php-pear", 
        "php5-dev", 
        "php-apc", 
        "php5-mcrypt", 
        "php5-gd", 
        "php5-curl",
        "php5-memcached",
        "php5-sqlite",
        "php5-xdebug",
        "php5-xmlrpc",
        "php5-json"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => Exec['apt-get update']
    }

    # upgrade pear
    exec {
        "pear upgrade":
            command => "/usr/bin/pear upgrade",
            require => Package['php-pear'],
            returns => [ 0, '', ' ']
    }

    # set channels to auto discover
    exec {
        "pear auto_discover" :
            command => "/usr/bin/pear config-set auto_discover 1",
            require => [Package['php-pear']]
    }

    exec {
        "pear update-channels" :
            command => "/usr/bin/pear update-channels",
            require => [Package['php-pear']]
    }

    exec {
        "pear install phpunit":
            command => "/usr/bin/pear install --alldeps pear.phpunit.de/PHPUnit",
            creates => '/usr/bin/phpunit',
            require => Exec['pear update-channels']
    }
}
