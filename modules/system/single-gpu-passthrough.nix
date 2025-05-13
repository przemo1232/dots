# about to hit a blunt for this one
{ config, pkgs, lib, ... }:

{
  boot.kernelParams = lib.mkAfter [ "amd_iommu=on" ];
  boot.blacklistedKernelModules = lib.mkAfter [ "amdgpu" ];
  boot.kernelModules = lib.mkAfter [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  boot.extraModprobeConfig = config.boot.extraModprobeConfig ++ "\noptions vfio-pci ids=10de:13c0,10de:0fbb";

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        ovmf = {
          enable = true;
        };
      };
    };
  };
}
