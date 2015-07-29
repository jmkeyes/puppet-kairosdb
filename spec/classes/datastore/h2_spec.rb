describe 'kairosdb::datastore::h2' do
  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::datastore::h2') }

    default_settings = [
      'kairosdb.service.datastore',
      'kairosdb.datastore.h2.database_path',
    ]

    default_settings.each do |setting|
      it { should contain_kairosdb__setting(setting) }

      it do
        should contain_augeas(setting).with({
          :incl => '/opt/kairosdb/conf/kairosdb.properties',
          :lens => 'Properties.lns',
        })
      end
    end
  end
end
