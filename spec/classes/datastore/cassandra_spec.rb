describe 'kairosdb::datastore::cassandra' do
  context "with hosts => [ '127.0.0.1:9160' ]" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    let (:params) do
      {
        :hosts => [ '127.0.0.1:9160' ],
      }
    end

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::datastore::cassandra') }

    default_settings = [
      'kairosdb.service.datastore',
      'kairosdb.datastore.cassandra.host_list',
      'kairosdb.datastore.cassandra.multi_row_read_size',
      'kairosdb.datastore.cassandra.read_consistency_level',
      'kairosdb.datastore.cassandra.replication_factor',
      'kairosdb.datastore.cassandra.row_width',
      'kairosdb.datastore.cassandra.single_row_read_size',
      'kairosdb.datastore.cassandra.write_consistency_level',
      'kairosdb.datastore.cassandra.write_delay',
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
