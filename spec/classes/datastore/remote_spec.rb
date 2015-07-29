describe 'kairosdb::datastore::remote' do
  context "with remote_url => 'http://10.92.1.41:8080'" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    let (:params) do
      {
        :remote_url => 'http://10.92.1.41:8080',
      }
    end

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::datastore::remote') }

    default_settings = [
      'kairosdb.service.datastore',
      'kairosdb.datastore.remote.data_dir',
      'kairosdb.datastore.remote.remote_url',
      'kairosdb.datastore.remote.random_delay',
      'kairosdb.datastore.remote.schedule',
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
