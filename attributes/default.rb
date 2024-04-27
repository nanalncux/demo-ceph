default['demo-ceph']['ceph'].tap do |ceph|
  ceph['adm']['version'] = ''
  ceph['docker']['version'] = ''
  ceph['release'] = ''
  ceph['id'] = ''
  ceph['mon_bootstrap_ip'] = ''

  ceph['cluster'].tap do |cluster|
    cluster['nodes'] = {}

    cluster['labels'].tap do |labels|
      labels['_admin'] = %w()
      labels['example-label'] = %w()
    end
    cluster['network'] = ''
  end
  ceph['monitor'] = ''
  ceph['grafana']['url'] = ''

  ceph['iscsi'].tap do |iscsi|
    # Этот атрибут должен быть STRING!
    iscsi['trusted_ip_list'] = ''
    iscsi['default_pool'] = ''
  end
end
