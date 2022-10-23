[all]
 node1 ansible_host=${vm1_internal_ip}  
 node2 ansible_host=${vm2_internal_ip} 

[kube_control_plane]
 node1

[etcd]
 node1

[kube_node]
 node2

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr