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
# None at the moment
#
# == Examples
#
# include slapcat
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class slapcat {

    # This class does nothing at the moment.

}
