# == Class: kairosdb::install::default

class kairosdb::install::default {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')

  $github_url     = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb-%s.tar.gz'
  $googlecode_url = 'https://kairosdb.googlecode.com/files/kairosdb-%s.tar.gz'

  $source = $::kairosdb::package_mirror ? {
    'github'     => sprintf($github_url, $release, $version),
    'googlecode' => sprintf($googlecode_url, $version),
  }

  staging::deploy { "kairosdb-${version}.tar.gz":
    creates => '/opt/kairosdb',
    source  => $source,
    target  => '/opt',
    user    => 'root',
    group   => 'root',
  } ->

  file { '/etc/init.d/kairosdb':
    ensure => link,
    target => '/opt/kairosdb/bin/kairosdb-service.sh'
  }
}
