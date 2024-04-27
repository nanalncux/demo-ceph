
status = shell_out('ceph -s 2>&1 | grep HEALTH_OK').stdout.split[1]

node['demo-ceph']['ceph']['cluster']['labels'].each() do |label, hosts|
  hosts.each() do |host|
    ceph_orch 'ceph host label add' do
      options "label add #{host}"
      args "#{label}"
      action :host
      only_if { status == 'HEALTH_OK' }
      only_if "ssh -o StrictHostKeyChecking=no root@#{host} hostname"
    end
  end
end
