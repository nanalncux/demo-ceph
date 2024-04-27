config_dbi = data_bag_item(:ceph, node.chef_environment)
admin_username = config_dbi['admin_username']
admin_password = config_dbi['admin_password']

file "/etc/ceph/dashboard-#{admin_username}.pass" do
  content admin_password
  owner 'root'
  group 'root'
  mode '600'
  action :create
end

ceph_dashboard 'ceph_dashboard' do
  username admin_username
  path_pass "/etc/ceph/dashboard-#{admin_username}.pass"
  action :adduser
end

ceph_dashboard 'ceph_dashboard' do
  username 'admin'
  action :disableuser
  only_if 'ceph dashboard ac-user-show admin'
end

ceph_dashboard 'ceph_dashboard' do
  options 'set-grafana-api-url'
  args node['demo-ceph']['ceph']['grafana']['url']
  action :config
end

ceph_dashboard 'ceph_dashboard' do
  options 'set-grafana-api-ssl-verify'
  args 'False'
  action :config
end
