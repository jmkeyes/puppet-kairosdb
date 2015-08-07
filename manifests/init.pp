# == Class: kairosdb

class kairosdb (
  $version         = undef,
  $package_name    = 'kairosdb',
  $package_ensure  = 'installed',
  $package_mirror  = 'github',
  $service_name    = 'kairosdb',
  $service_ensure  = 'running',
  $service_enable  = true,
  $manage_service  = true,
  $manage_package  = true,
  $settings        = {},
  $base_path       = '/opt/kairosdb',
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  if $version == undef {
    fail('You must manually select a version of KairosDB to deploy.')
  } else {
    validate_re($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$')
  }

  if $::kairosdb::package_mirror in [ 'github', 'googlecode' ] == false {
    fail("Unsupported package mirror: ${::kairosdb::package_mirror}!")
  }

  contain '::kairosdb::install'
  contain '::kairosdb::config'
  contain '::kairosdb::service'

  Class['::kairosdb::install'] ->
  Class['::kairosdb::config'] ~>
  Class['::kairosdb::service']
}
