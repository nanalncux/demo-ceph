provides :cephadm
unified_mode true

property :mon_ip, String
property :ssh_private_key, String
property :ssh_public_key, String
property :cluster_network, String
property :fsid, String
property :release, String
property :pass, String

action :bootstrap do
  options = " --mon-ip #{new_resource.mon_ip}" if new_resource.mon_ip
  options << " --ssh-private-key #{new_resource.ssh_private_key} --ssh-public-key #{new_resource.ssh_public_key}" if new_resource.ssh_private_key && new_resource.ssh_public_key
  options << " --cluster-network #{new_resource.cluster_network}" if new_resource.cluster_network
  options << " --fsid #{new_resource.fsid}" if new_resource.fsid
  options << " --initial-dashboard-user  admin --initial-dashboard-password #{new_resource.pass} --dashboard-password-noupdate --allow-fqdn-hostname" if new_resource.pass
  cmd_text = "cephadm bootstrap #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "cephadm : #{cmd.stderr}"
end

action :addrepo do
  options = " #{new_resource.release}" if new_resource.release
  cmd_text = "cephadm add-repo --release #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "cephadm : #{cmd.stderr}"
end
