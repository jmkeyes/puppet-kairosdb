# == Class: kairosdb::install::default
#
# Copyright 2016 Joshua M. Keyes <joshua.michael.keyes@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
