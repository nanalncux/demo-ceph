
%w(/etc/ceph /etc/docker /root/ceph-service-spec).each() do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

template '/etc/docker/daemon.json' do
  source 'daemon.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

apt_package 'docker-ce' do
  version node['demo-ceph']['docker']['version']
  action  :install
end

apt_package 'cephadm' do
  version node['demo-ceph']['ceph']['adm']['version']
  action  :install
end

cephadm 'cephadm' do
  release node['demo-ceph']['ceph']['release']
  action :addrepo
end

%w(chrony ceph-common).each() do |pkg|
  apt_package pkg do
    action :install
  end
end

config_dbi = data_bag_item(:ceph, node.chef_environment)
private_key = config_dbi['private_key']
public_key = config_dbi['public_key']

file '/root/.ssh/id_ed25519' do
  content private_key
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end

file '/root/.ssh/id_ed25519.pub' do
  content public_key
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end

file '/root/.ssh/authorized_keys' do
  content public_key
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end
