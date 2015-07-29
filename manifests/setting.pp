# == Define: kairosdb::setting

define kairosdb::setting (
  $value  = undef,
) {
  augeas { $name:
    require => File["${::kairosdb::base_path}/conf/kairosdb.properties"],
    incl    => "${::kairosdb::base_path}/conf/kairosdb.properties",
    changes => [ "set ${name} ${value}" ],
    lens    => 'Properties.lns',
  }
}
