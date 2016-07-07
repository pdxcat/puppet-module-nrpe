require 'spec_helper'

describe 'nrpe::plugin', :type => :define do

  let :facts do
    {
      :osfamily     => 'Debian',
      :architecture => 'x86_64',
    }
  end

  let (:title) {'check_users'}
  let :params do
    {
      :ensure  => 'present',
    }
  end

  context 'default module params' do
    let(:pre_condition) { 'include nrpe' }

    it { is_expected.to compile.with_all_deps }
    it { should contain_file('/usr/lib/nagios/plugins/check_users') }
  end

  context 'include nrpe with different package name' do
    let(:pre_condition) do
      '
      class { "nrpe":
        package_name => "nrpe",
      }
      '
    end

    it { is_expected.to compile.with_all_deps }
    it { should contain_file('/usr/lib/nagios/plugins/check_users').with_require('Package[nrpe]') }
  end
end
