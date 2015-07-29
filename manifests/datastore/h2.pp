# == Class: kairosdb::datastore::h2

class kairosdb::datastore::h2 (
  $database_path = 'build/h2db'
) {
  kairosdb::setting { 'kairosdb.service.datastore':
    value => 'org.kairosdb.datastore.h2.H2Module',
  }

  kairosdb::setting { 'kairosdb.datastore.h2.database_path':
    value => $database_path,
  }
}
