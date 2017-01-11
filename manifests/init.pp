# == Class: kairosdb
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

class kairosdb (
  $version           = undef,
  $package_name      = 'kairosdb',
  $package_ensure    = undef,
  $package_mirror    = 'github',
  $service_name      = 'kairosdb',
  $service_ensure    = 'running',
  $service_enable    = true,
  $service_hasstatus = false,
  $manage_service    = true,
  $manage_package    = true,
  $settings          = {},
  $base_path         = '/opt/kairosdb',
  $custom_url        = undef,
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
  if $package_ensure == undef {
      $package_ensure_real = $version
  } else {
      $package_ensure_real = $package_ensure
  }

  if $::kairosdb::package_mirror == 'custom_repo' and $::kairosdb::custom_url == undef {
      fail('Custom repo selected and custom_repo url not defined')
  }

  if $::kairosdb::package_mirror in [ 'github', 'googlecode','custom_repo' ] == false {
    fail("Unsupported package mirror: ${::kairosdb::package_mirror}!")
  }

  contain '::kairosdb::install'
  contain '::kairosdb::config'
  contain '::kairosdb::service'

  Class['::kairosdb::install'] ->
  Class['::kairosdb::config'] ~>
  Class['::kairosdb::service']
}
