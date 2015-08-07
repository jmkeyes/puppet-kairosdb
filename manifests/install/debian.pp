# == Class: kairosdb::install::debian

class kairosdb::install::debian {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')

  $github_url     = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb_%s_all.deb'
  $googlecode_url = 'https://kairosdb.googlecode.com/files/kairosdb_%s_all.deb'

  $source = $::kairosdb::package_mirror ? {
    'github'     => sprintf($github_url, $release, $version),
    'googlecode' => sprintf($googlecode_url, $version),
  }

  staging::file { "kairosdb_${version}_all.deb":
    source => $source,
  } ->

  package { $::kairosdb::package_name:
    ensure   => $::kairosdb::package_ensure,
    source   => "${::staging::path}/kairosdb/kairosdb_${version}_all.deb",
    provider => 'dpkg',
  }
}
