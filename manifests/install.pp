# == Class: kairosdb::install

class kairosdb::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  if $::kairosdb::manage_package {
    case $::osfamily {
      'RedHat': { contain '::kairosdb::install::redhat'  }
      'Debian': { contain '::kairosdb::install::debian'  }
      default:  { contain '::kairosdb::install::default' }
    }
  }
}
