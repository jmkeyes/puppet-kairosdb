describe 'kairosdb::config' do
  context 'when included without kairosdb' do
    it { should raise_error(Puppet::Error, /Use of private class kairosdb::config from/) }
  end

  context "with default parameters" do
    let (:pre_condition) { 'include "::kairosdb" ' }
    it { should raise_error(Puppet::Error, /You must manually select a version of KairosDB to deploy\./) }
  end

  context "with version => '0.9.4-6'" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::config') }

    it do
      should contain_file('/opt/kairosdb/conf/kairosdb.properties').with({
        :ensure => 'present',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0644',
      })
    end
  end
end
