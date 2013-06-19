#
# == Define: slapcat::backup
#
# Dump LDAP databases to a directory using slapcat and compress them using gzip. 
# New dumps overwrite the old ones, the idea being that a backup application 
# (e.g. rsnapshot or bacula) fetches the latest local backups at regular 
# intervals and no local versioning is thus necessary.
# 
# This define depends on the 'localbackups' class. Also, the 'slapcat' class has 
# to be included or this define won't be found.
#
# == Parameters
#
# [*status*]
#   Status of the backup job. Either 'present' or 'absent'. Defaults to 
#   'present'.
# [*suffix*]
#   The suffix of the LDAP directory to backup. The value is automatically 
#   quoted and can have spaces in it. For example 'dc=domain,dc=com'.
# [*output_dir*]
#   The directory where to output the files. Defaults to /var/backups/local.
# [*slapcat_extra_params*]
#   Extra parameters to pass to slapcat. Make sure you use proper escaping if
#   option values have spaces in them.
# [*hour*]
#   Hour(s) when the agent gets run. Defaults to * (all hours).
# [*minute*]
#   Minute(s) when the agent gets run. Defaults to 50.
# [*weekday*]
#   Weekday(s) when the agent gets run. Defaults to * (all weekdays).
#
# == Examples
#
# slapcat::backup { 'ldap_directory':
#   suffix => 'dc=domain,dc=com',
# }
#
# slapcat::backup { 'configdb':
#   suffix => 'cn=config',
# }
# 
define slapcat::backup
(
    $status = 'present',
    $suffix,
    $output_dir = '/var/backups/local',
    $slapcat_extra_params = '',
    $hour = '4',
    $minute = '30',
    $weekday = '*',
)
{

    include slapcat

    # We need this so that we don't end up with useless "" in the command-line 
    # which would upset slapcat's option parser
    if $slapcat_extra_params == '' {
        $cron_command = "slapcat -b \"${suffix}\"|gzip > \"${output_dir}/slapcat-${suffix}.ldif.gz\""
    } else {
        $cron_command = "slapcat -b \"${suffix}\" ${slapcat_extra_params}|gzip > \"${output_dir}/slapcat-${suffix}.ldif.gz\""
    }

    cron { "slapcat-backup-${suffix}-cron":
        ensure => $status,
        command => $cron_command,
        user => root,
        hour => $hour,
        minute => $minute,
        weekday => $weekday,
        environment => 'PATH=/bin:/usr/bin:/usr/sbin',
        require => Class['localbackups'],
    }
}
