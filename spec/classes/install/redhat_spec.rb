describe 'kairosdb::install::redhat' do
  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::install::redhat') }
    it { should contain_staging__file('kairosdb-0.9.4-6.rpm') }
  end
end
