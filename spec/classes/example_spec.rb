require 'spec_helper'

describe 'role_db' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir  => "/foo",
            :db_export_net   => "localhost",
            :monitor_address => "localhost",
          })
        end

        context "role_db class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('role_db') }
          it { is_expected.to contain_class('profile_base') }
          it { is_expected.to contain_class('profile_mysql') }
          it { is_expected.to contain_class('profile_redis') }

        end
      end
    end
  end
end
