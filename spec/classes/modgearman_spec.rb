require 'spec_helper'
describe 'gearman::modgearman' do
  let :params do
    {
      ensure: 'present',
      package: 'mod_gearman',
      config_file: 'worker.conf',
      config_path: '/etc/mod_gearman',
      config_template: 'worker.conf.erb',
      service_name: 'mod-gearman.worker'
    }
  end
  it { is_expected.to compile }
  it { is_expected.to contain_package('mod_gearman').with_ensure('present') }
  it { is_expected.to contain_file('worker.conf').with('ensure' => 'present', 'path' => '/etc/mod_gearman', 'require' => 'Package[mod_gearman]' ) }
  it { is_expected.to contain_service('mod-gearman.worker').with('ensure' => 'running', 'hasrestart' => true, 'hasstatus' => true, 'provider' => 'systemd') }

end
