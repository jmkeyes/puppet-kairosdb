describe 'kairosdb::install::debian' do
  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::install::debian') }
    it { should contain_staging__file('kairosdb_0.9.4-6_all.deb') }
  end
end
