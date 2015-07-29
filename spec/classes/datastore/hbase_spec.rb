describe 'kairosdb::datastore::hbase' do
  it { should raise_error(Puppet::Error, /KairosDB no longer supports the HBase datastore!/) }
end
