require 'spec_helper'

describe 'nrpe::plugin', :type => :define do

    let(:pre_condition) { 'include nrpe' }

    let :facts do
     { :osfamily => 'Debian', }
    end

    let (:title) {'check_users'}

    describe 'should check for $content and $source' do
      let :params do
        {
          :ensure  => 'present',
        }
      end

      it do
        expect {
          should contain_file('/usr/lib/nagios/plugins/check_users')
        }.to raise_error(Puppet::Error, /Either \$content or \$source must be defined!/)
      end
    end

    describe 'should contain plugin file' do
      let :params do
        {
          :ensure  => 'present',
          :content => 'exit 0',
        }
      end

      it { should contain_file('/usr/lib/nagios/plugins/check_users') }
    end
end
