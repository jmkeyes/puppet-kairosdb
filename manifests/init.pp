# == Class: kairosdb

class kairosdb {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::kairosdb::install'
  contain '::kairosdb::config'
  contain '::kairosdb::service'

  Class['::kairosdb::install'] ->
  Class['::kairosdb::config'] ~>
  Class['::kairosdb::service']
}
