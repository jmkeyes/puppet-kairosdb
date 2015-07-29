# == Class: kairosdb::install::debian

class kairosdb::install::debian {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')
  $source  = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb_%s_all.deb'

  staging::file { "kairosdb_${version}_all.deb":
    source => sprintf($source, $release, $version),
  } ->

  package { $::kairosdb::package_name:
    ensure   => $::kairosdb::package_ensure,
    source   => "${::staging::path}/kairosdb/kairosdb_${version}_all.deb",
    provider => 'dpkg',
  }
}
