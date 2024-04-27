apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  distribution "#{node['lsb']['codename']}"
  components ['stable']
  key 'https://download.docker.com/linux/ubuntu/gpg'
end

execute 'ceph gpg' do
  command "wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -"
end

apt_repository 'ceph' do
  uri 'https://download.ceph.com/debian-reef'
  distribution "#{node['lsb']['codename']}"
  components ['main']
end

apt_update 'update' do
  action :update
end

node['testring']['hosts'].each() do |host, addr|
  hostsfile_entry "#{addr}" do
    hostname "#{host}"
    action :create_if_missing
  end
end
