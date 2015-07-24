describe 'kairosdb' do
  context 'with Puppet <= 3.7.0' do
    let (:facts) do
      {
        :puppetversion => '3.6.0'
      }
    end

    it { should raise_error(Puppet::Error, /This module requires the use of Puppet v3.7.0 or newer./) }
  end

  shared_examples 'a Linux distribution' do |osfamily|
    context "with default parameters on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('kairosdb') }
      it { should contain_class('kairosdb::install').that_comes_before('Class[kairosdb::config]') }
      it { should contain_class('kairosdb::config').that_requires('Class[kairosdb::install]') }
      it { should contain_class('kairosdb::config').that_notifies('Class[kairosdb::service]') }
      it { should contain_class('kairosdb::service').that_subscribes_to('Class[kairosdb::config]') }
    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
