# == Class: kairosdb::config

class kairosdb::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  file { "${::kairosdb::base_path}/conf/kairosdb.properties":
    ensure  => present,
    require => Class['::kairosdb::install'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if empty($::kairosdb::settings) == false {
    $settings = $::kairosdb::settings
    $convert  = "(@settings.inject({}){|o,(k,v)|;o[k]={'value'=>v};o})"
    $options  = parsejson(inline_template("<%= ${convert}.to_json %>"))
    create_resources('kairosdb::setting', $options)
  }
}
