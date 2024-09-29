{ lib, ... }:
{
  imports = [
    ./ansible
    ./aws-cli
    ./git
    ./go
    ./hashicorp
    ./packer
    ./powershell
    ./python
    ./virtualization
    ./yaml
  ];

  # wonder what happens when the packages enable options are already declared here
  options = {
    kdlt.development = {
      ansible.enable = lib.mkEnableOption "Ansible";
      aws-cli.enable = lib.mkEnableOption "Aws-cli";
      azure-cli.enable = lib.mkEnableOption "Azure-cli";
      git.enable = lib.mkEnableOption "Git";
      go.enable = lib.mkEnableOption "Go";
      powershell.enable = lib.mkEnableOption "Powershell";
      python.enable = lib.mkEnableOption "Python312";
      virtualization = {
        docker.enable = lib.mkEnableOption "Docker";
        hypervisor.enable = lib.mkEnableOption "Libvirt/KVM";
        k8s.enable = lib.mkEnableOption "k8s tooling";
      };
      yaml.enable = lib.mkEnableOption "Yaml";
    };
  };

  config = {
    kdlt.development = with lib; {
      ansible.enable = mkDefault true;
      aws-cli.enable = mkDefault true;
      git.enable = mkDefault true;
      go.enable = mkDefault true;
      hashicorp.enable = mkDefault true;
      packer.enable = mkDefault true;
      powershell.enable = mkDefault true;
      python.enable = mkDefault true;
      yaml.enable = mkDefault true;
      virtualization = {
        docker.enable = mkDefault true;
        k8s.enable = mkDefault true;
        hypervisor.enable = mkDefault true;
      };
    };
  };
}
