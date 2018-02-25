#!/bin/sh
echo "Get path of vmdk for vm with proxycp"
java -jar proxycp.jar --listpermission --vm your-client-name --force
#
echo " "
echo "Create the dataset"
echo "mccli dataset add --domain=your.vmware.domain.com --name=your-client-name-HD1"
mccli dataset add --domain=your.vmware.domain.com --name=your-client-name-HD1
echo " "
echo "Add target to dataset. This is the .vmdk file for the first hard disk"
echo " "
echo "mccli dataset add-target --name=your.vmware.domain.com/your-client-name-HD1 --plugin=1016 --target=[DATACENTER_9999_HDS_VSP_FC_L002] your-client-name/your-client-name.vmdk"
mccli dataset add-target --name=your.vmware.domain.com/your-client-name-HD1 --plugin=1016 --target="[DATACENTER_9999_HDS_VSP_FC_L002] your-client-name/your-client-name.vmdk"
echo " "
echo "Create Group for VM"
#
echo "mccli group add --dataset=your-client-name-HD1 --dataset-domain=your.vmware.domain.com --domain=your.vmware.domain.com/VirtualMachines  --enabled=true --name=your-name"
mccli group add --dataset=your-client-name-HD1 --dataset-domain=your.vmware.domain.com --domain=your.vmware.domain.com/VirtualMachines  --enabled=true --name=your-name
#
echo " "
echo "mccli group add-client --client-domain=your.vmware.domain.com/VirtualMachines --client-name=your-client-name --domain=your.vmware.domain.com/VirtualMachines --name=your-client-name"
mccli group add-client --client-domain=your.vmware.domain.com/VirtualMachines --client-name=your-client-name --domain=your.vmware.domain.com/VirtualMachines --name=your-name
#
echo " "
echo "Add proxy(s) to the group"
echo "mccli group add-proxy --domain=your.vmware.domain.com/VirtualMachines  --name=your-name --proxy-domain=FMOandCloud --proxy-name=your-proxy-1"
mccli group add-proxy --domain=your.vmware.domain.com/VirtualMachines  --name=your-name --proxy-domain=FMOandCloud --proxy-name=your-proxy-1
echo "mcclii group add-proxy --domain=your.vmware.domain.com/VirtualMachines  --name=your-name --proxy-domain=proxy --proxy-name=your-proxy"
mccli group add-proxy --domain=your.vmware.domain.com/VirtualMachines  --name=your-name --proxy-domain=proxy --proxy-name=your-proxy
echo " "
#echo "Add schedue to the group"
echo " "
#mccli group edit --dataset=your-client-name-HD1  --dataset-domain=your.vmware.domain.com --domain=your.vmware.domain.com/VirtualMachines --enabled=true --encryption=none --name=your-machine-name --retention=
echo "mccli group backup --domain=your.vmware.domain.com/VirtualMachines --name=your-name"
mccli group backup --domain=your.vmware.domain.com/VirtualMachines --name=your-name
#
echo " "
echo "mccli show activity | grep your-client-name"
mccli activity show | grep 0500
