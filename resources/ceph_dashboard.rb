provides :ceph_dashboard
unified_mode true

property :options, String
property :args, String
property :username, String
property :path_pass, String

action :adduser do
  options = " #{new_resource.username} -i #{new_resource.path_pass}" if new_resource.username && new_resource.path_pass
  cmd_text = "ceph dashboard ac-user-create #{options} administrator"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "dashboard create user: #{cmd.stderr}"
end

action :disableuser do
  options = " #{new_resource.username}" if new_resource.username
  cmd_text = "ceph dashboard ac-user-disable #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "dashboard disable user: #{cmd.stderr}"
end

action :config do
  options = " #{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph dashboard #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "#{new_resource.options}: #{cmd.stderr}"
end
