# == Class: kairosdb::install::redhat

class kairosdb::install::redhat {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')

  $github_url     = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb-%s.rpm'
  $googlecode_url = 'https://kairosdb.googlecode.com/files/kairosdb-%s.rpm'

  $source = $::kairosdb::package_mirror ? {
    'github'     => sprintf($github_url, $release, $version),
    'googlecode' => sprintf($googlecode_url, $version),
  }

  staging::file { "kairosdb-${version}.rpm":
    source => $source,
  } ->

  package { $::kairosdb::package_name:
    ensure   => $::kairosdb::package_ensure,
    source   => "${::staging::path}/kairosdb/kairosdb-${version}.rpm",
    provider => 'rpm',
  }
}
