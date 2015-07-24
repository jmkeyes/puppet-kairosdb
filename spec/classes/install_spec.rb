describe 'kairosdb::install' do
  context 'when included without kairosdb' do
    it { should raise_error(Puppet::Error, /Use of private class kairosdb::install from/) }
  end

  shared_examples 'a Linux distribution' do |osfamily|
    let (:pre_condition) { 'include ::kairosdb' }

    let (:facts) do
      {
        :operatingsystem => osfamily,
        :osfamily        => osfamily,
      }
    end

    context "on #{osfamily}" do
      it { should compile.with_all_deps }
      it { should create_class('kairosdb::install') }
    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
