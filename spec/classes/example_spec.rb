require 'spec_helper'

describe 'role_db' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "role_db class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('role_db') }
          it { is_expected.to contain_class('profile_base') }
          it { is_expected.to contain_class('profile_mysql') }

          it { is_expected.to contain_mysql__db('nd-app') }
          it { is_expected.to contain_mysql_database('nd-app') }
          it { is_expected.to contain_mysql_user('nd-app@%') }

        end
      end
    end
  end
end
