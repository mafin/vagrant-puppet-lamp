class other 
{
     $packages = [
        "curl",
        "unzip",
        "mc",
        "imagemagick",
        "redis-server"
    ]

    package
    {
        $packages:
            ensure  => present,
            require => Exec['apt-get update']
    }
}
