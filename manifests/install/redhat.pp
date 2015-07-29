# == Class: kairosdb::install::redhat

class kairosdb::install::redhat {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')
  $source  = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb-%s.rpm'

  staging::file { "kairosdb-${version}.rpm":
    source => sprintf($source, $release, $version),
  } ->

  package { $::kairosdb::package_name:
    ensure   => $::kairosdb::package_ensure,
    source   => "${::staging::path}/kairosdb/kairosdb-${version}.rpm",
    provider => 'rpm',
  }
}
