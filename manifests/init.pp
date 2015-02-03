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
    $backups = {}
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_slapcat', 'true') != 'false' {



    # Realize the defined backup jobs
    create_resources('slapcat::backup', $backups)
}
}
