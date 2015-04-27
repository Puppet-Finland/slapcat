#
# == Class: slapcat
#
# Class to setup and configure slapcat. Currently only exists so that 
# slapcat::backup defines can be created. Separation of this class from the 
# openldap class allows management of slapcat backups, while keeping openldap 
# management separate.
#
# == Parameters
#
# [*manage*]
#  Whether to manage slapcat with Puppet or not. Valid values are 'yes' 
#  (default) and 'no'.
# [*backups*]
#   A hash of slapcat::backup resources to realize
#
# == Examples
#
#    include slapcat
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class slapcat
(
    $manage = 'yes',
    $backups = {}
)
{

if $manage == 'yes' {

    # Realize the defined backup jobs
    create_resources('slapcat::backup', $backups)
}
}
