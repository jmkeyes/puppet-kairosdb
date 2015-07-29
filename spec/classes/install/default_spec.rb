describe 'kairosdb::install::default' do
  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::install::default') }
    it { should contain_staging__deploy('kairosdb-0.9.4-6.tar.gz') }
  end
end
