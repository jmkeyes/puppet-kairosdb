# == Class: kairosdb::service

class kairosdb::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  if $::kairosdb::manage_service {
    service { $::kairosdb::service_name:
      ensure => $::kairosdb::service_ensure,
      enable => $::kairosdb::service_enable,
    }
  }
}
