describe 'kairosdb::install' do
  context 'when included without kairosdb' do
    it { should raise_error(Puppet::Error, /Use of private class kairosdb::install from/) }
  end

  context "with default parameters" do
    let (:pre_condition) { 'class { "::kairosdb": version => "0.9.4-6" }' }

    it { should compile.with_all_deps }
    it { should create_class('kairosdb::install') }

    describe "with $::osfamily => 'RedHat'" do
      let (:facts) { { :osfamily => 'RedHat' } }
      it { should contain_class('kairosdb::install::redhat') }
      it { should contain_package('kairosdb') }
    end

    describe "with $::osfamily => 'Debian'" do
      let (:facts) { { :osfamily => 'Debian' } }
      it { should contain_class('kairosdb::install::debian') }
      it { should contain_package('kairosdb') }
    end

    describe "with an unknown $::osfamily" do
      it { should contain_class('kairosdb::install::default') }
      it { should contain_file('/etc/init.d/kairosdb') }
    end
  end
end
