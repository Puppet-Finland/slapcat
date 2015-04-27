#
# == Class: slapcat::params
#
# Defines some variables based on the operating system
#
class slapcat::params {

    include ::os::params

    case $::osfamily {
        'Debian': {
            $package_name = 'slapcat'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
