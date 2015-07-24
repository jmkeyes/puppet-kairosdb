describe 'kairosdb::config' do
  context 'when included without kairosdb' do
    it { should raise_error(Puppet::Error, /Use of private class kairosdb::config from/) }
  end

  shared_examples 'a Linux distribution' do |osfamily|
    context "on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      describe "with default parameters" do
        let (:pre_condition) { 'include ::kairosdb' }

        it { should compile.with_all_deps }
        it { should create_class('kairosdb::config') }
      end
    end
  end

  it_behaves_like "a Linux distribution", 'RedHat'
  it_behaves_like "a Linux distribution", 'Debian'
end
