acl zeit {
    "127.0.0.1";        # localhost
    "10.100.0.0"/16;    # Server HH
    "10.30.0.0"/21;     # ZON HH
    "10.30.8.0"/21;     # ZON Ber
    "10.200.200.0"/21;  # OpenVPN
    "10.210.0.0"/21;    # OpenVPN
    "10.110.0.0"/16;    # Google k8s ("GKE staging", eigentlich 10.110.16.0/20)
    "10.111.48.0"/20;   # Google k8s production (siehe terraform-ops/.../production/gke.tf)
    "10.111.32.0"/20;   # Google k8s staging (siehe terraform-ops/.../staging/gke-ip-masq-agent.tf)
    "194.77.156.0"/23;  # ZON HH public
    "217.13.68.0"/23;   # Gaertner
}
