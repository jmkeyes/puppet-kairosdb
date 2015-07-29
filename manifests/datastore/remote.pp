# == Class: kairosdb::datastore::remote

class kairosdb::datastore::remote (
  $remote_url,
  $data_dir     = '.',
  $on_schedule  = '0 */30 * * * ?',
  $random_delay = 0,
) {
  validate_string($remote_url)
  validate_string($data_dir)
  validate_string($schedule)

  validate_integer($random_delay)

  kairosdb::setting { 'kairosdb.service.datastore':
    value => 'org.kairosdb.datastore.remote.RemoteModule',
  }

  kairosdb::setting { 'kairosdb.datastore.remote.remote_url':
    value => $remote_url,
  }

  kairosdb::setting { 'kairosdb.datastore.remote.data_dir':
    value => $data_dir,
  }

  kairosdb::setting { 'kairosdb.datastore.remote.schedule':
    value => $on_schedule,
  }

  kairosdb::setting { 'kairosdb.datastore.remote.random_delay':
    value => $random_delay,
  }
}
