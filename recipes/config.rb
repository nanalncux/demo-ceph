config_dbi = data_bag_item(:ceph, node.chef_environment)
admin_password = config_dbi['admin_password']

cephadm 'cephadm' do
  mon_ip node['demo-ceph']['ceph']['mon_bootstrap_ip']
  ssh_private_key '/root/.ssh/id_ed25519'
  ssh_public_key '/root/.ssh/id_ed25519.pub'
  fsid node['demo-ceph']['ceph']['id']
  cluster_network node['demo-ceph']['ceph']['cluster']['network']
  pass admin_password
  action :bootstrap
  not_if 'ceph -s'
end

chef_sleep 'ceph bootstrap pause' do
  seconds 60
end

ceph_orch 'set monitor variable' do
  options 'mon'
  args node['demo-ceph']['ceph']['monitor']
  action :apply
end
