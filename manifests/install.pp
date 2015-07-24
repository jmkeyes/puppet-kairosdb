# == Class: kairosdb::install

class kairosdb::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }
}
