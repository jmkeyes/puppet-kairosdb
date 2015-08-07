describe 'kairosdb' do
  context 'with Puppet <= 3.7.0' do
    let (:facts) { { :puppetversion => '3.6.0' } }
    it { should raise_error(Puppet::Error, /This module requires the use of Puppet v3.7.0 or newer./) }
  end

  context "with default parameters" do
    it { should raise_error(Puppet::Error, /You must manually select a version of KairosDB to deploy\./) }
  end

  context "with version => '0.9.4-6'" do
    let (:params) { { :version => '0.9.4-6' } }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb') }
    it { should contain_class('kairosdb::install').that_comes_before('Class[kairosdb::config]') }
    it { should contain_class('kairosdb::config').that_requires('Class[kairosdb::install]') }
    it { should contain_class('kairosdb::config').that_notifies('Class[kairosdb::service]') }
    it { should contain_class('kairosdb::service').that_subscribes_to('Class[kairosdb::config]') }

  end

  context "with package_mirror => 'unknown'" do
    let (:params) { { :version => '0.9.4-6', :package_mirror => 'unknown' } }
    it { should raise_error(Puppet::Error, /Unsupported package mirror: unknown!/) }
  end
end
