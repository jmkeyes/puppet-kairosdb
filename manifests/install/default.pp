# == Class: kairosdb::install::default

class kairosdb::install::default {
  include '::staging'

  $version = $::kairosdb::version
  $release = regsubst($version, '^(\d+\.\d+\.\d+)(?:-(\d+))?$', '\1')
  $source  = 'https://github.com/kairosdb/kairosdb/releases/download/v%s/kairosdb-%s.tar.gz'

  staging::deploy { "kairosdb-${version}.tar.gz":
    source  => sprintf($source, $release, $version),
    creates => '/opt/kairosdb',
    target  => '/opt',
    user    => 'root',
    group   => 'root',
  } ->

  file { '/etc/init.d/kairosdb':
    ensure => link,
    target => '/opt/kairosdb/bin/kairosdb-service.sh'
  }
}
