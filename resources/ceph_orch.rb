provides :ceph_orch
unified_mode true

property :options, String
property :args, String

action :apply do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch apply #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch apply: #{cmd.stderr}"
end

action :specapply do
  options = "#{new_resource.options}" if new_resource.options
  cmd_text = "ceph orch apply -i #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch spec-apply: #{cmd.stderr}"
end

action :host do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch host #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch host: #{cmd.stderr}"
end

action :client_keyring do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch client-keyring #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch client-keyring: #{cmd.stderr}"
end

action :daemon do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch daemon #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch daemon: #{cmd.stderr}"
end

action :osd do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch osd #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch osd: #{cmd.stderr}"
end

action :device do
  options = "#{new_resource.options} #{new_resource.args}" if new_resource.options && new_resource.args
  cmd_text = "ceph orch device #{options}"
  cmd = Mixlib::ShellOut.new(cmd_text)
  cmd.run_command
  cmd.error!
  Chef::Log.debug "ceph orch device: #{cmd.stderr}"
end
