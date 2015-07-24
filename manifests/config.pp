# == Class: kairosdb::config

class kairosdb::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }
}
