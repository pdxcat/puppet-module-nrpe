require 'spec_helper'

describe 'nrpe' do

  let :facts do
    { osfamily: 'RedHat' ,
      architecture: 'x86_64',}
  end

  it { is_expected.to compile.with_all_deps }
  it { should contain_package('nrpe').with_ensure('installed') }
  it { should contain_package('nagios-plugins-all').with_ensure('installed') }
  it { should contain_service('nrpe').with_ensure('running') }
  it { should contain_file('nrpe_config') }
  it { should contain_file('nrpe_include_dir').with_ensure('directory') }
  it { should contain_file('nrpe_pid_dir').with_ensure('directory') }

  context 'when manage_package is false' do
    let(:params) {{:manage_package => false}}

    it { should_not contain_package('nrpe') }
  end

  context 'when manage_pid_dir is false' do
    let(:params) {{:manage_pid_dir => false}}

    it { should_not contain_file('nrpe_pid_dir') }
  end
end
