
node['demo-ceph']['ceph']['cluster']['nodes'].each() do |key, value|
  ceph_orch 'ceph_orch' do
    options "add #{key}"
    args "#{value}"
    action :host
    only_if "ssh -o StrictHostKeyChecking=no root@#{value} hostname"
  end
end
