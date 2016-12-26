# Network #
network_name = "demo-network"

# Allow TCP FW #
fw_name     = "ssh"
allow_ports = ["22"]

# Demo Node #
demo_node_image         = "ubuntu-1404-trusty-v20161205"
demo_node_machine_type  = "f1-micro"
demo_node_zone          = "europe-west1-b"
#demo_node_network_id    = "demo-network"
demo_node_count         = "1"
#demo_node_owner        = ""
public_key_path = "~/.ssh/id_rsa.pub"
private_key_path = "~/.ssh/id_rsa"
