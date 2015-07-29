describe 'kairosdb::service' do
  context 'when included without kairosdb' do
    it { should raise_error(Puppet::Error, /Use of private class kairosdb::service from/) }
  end

  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::service') }
    it { should contain_service('kairosdb') }
  end
end
