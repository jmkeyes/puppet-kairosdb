# == Class: kairosdb::datastore::cassandra
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

class kairosdb::datastore::cassandra (
  $hosts,
  $username                = undef,
  $password                = undef,
  $replication_factor      = 1,
  $row_width               = 7257600000,
  $write_delay             = 1000,
  $single_row_read_size    = 10240,
  $multi_row_read_size     = 1024,
  $read_consistency_level  = 'ONE',
  $write_consistency_level = 'QUORUM',
) {
  require '::kairosdb'

  validate_array($hosts)

  validate_integer($replication_factor)
  validate_integer($row_width)
  validate_integer($write_delay)
  validate_integer($single_row_read_size)
  validate_integer($multi_row_read_size)

  validate_string($read_consistency_level)
  validate_string($write_consistency_level)

  kairosdb::setting { 'kairosdb.service.datastore':
    value => 'org.kairosdb.datastore.cassandra.CassandraModule',
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.host_list':
    value => join($hosts, ','),
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.replication_factor':
    value => $replication_factor,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.row_width':
    value => $row_width,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.write_delay':
    value => $write_delay,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.single_row_read_size':
    value => $single_row_read_size,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.multi_row_read_size':
    value => $multi_row_read_size,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.read_consistency_level':
    value => $read_consistency_level,
  }

  kairosdb::setting { 'kairosdb.datastore.cassandra.write_consistency_level':
    value => $write_consistency_level,
  }

  if $password != undef and $username != undef {
    validate_string($password)
    validate_string($username)

    kairosdb::setting { 'kairosdb.datastore.cassandra.auth.username':
      value => $username,
    }

    kairosdb::setting { 'kairosdb.datastore.cassandra.auth.password':
      value => $username,
    }
  }
}
