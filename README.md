# openvino-buildpack

install docker on linux
download pack cli from buildpacks.io

# Download Openvino Installer from https://storage.openvinotoolkit.org/repositories/openvino/packages/2022.3/linux

```console
mkdir openvino_installer
cd openvino_installer
wget https://storage.openvinotoolkit.org/repositories/openvino/packages/2022.3/linux/l_openvino_toolkit_ubuntu18_2022.3.0.9052.9752fafe8eb_x86_64.tgz
```

# Build the stack

```console
cd ../
export MYREG=myregistry.com
docker build -t ${MYREG}/openvino-stack-base:bionic --target base . -f Dockerfile-openvino-stack-bionic
docker build -t ${MYREG}/openvino-stack-run:bionic --target run . -f Dockerfile-openvino-stack-bionic
docker build -t ${MYREG}/openvino-stack-build:bionic --target build . -f Dockerfile-openvino-stack-bionic

docker push ${MYREG}/openvino-stack-base:bionic
docker push ${MYREG}/openvino-stack-run:bionic
docker push ${MYREG}/openvino-stack-build:bionic
```

# Create the builder

```console
pack builder create openvino-builder:bionic --config ./builder.toml -v
```

# KPack/Tanzu Build Service (optional)

if you are using Kpack or Tanzu Build Service, you need to create a CustomStack and custom ClusterBuilder inside your target kubernetes cluster where kpack is deployed.
1. edit OpenvinoCustomStack.yaml to point to your built images for build and run, you must use the sha references to the images
2. kubectl apply -f OpenvinoCustomStack.yaml
3. use KPAck cli to create a custom ClusterBuilder:  kp clusterbuilder create openvino-builder --tag harbor.services.edge.wrightcode.io:9443/library/openvino-builder:1.0.0 --stack stack-sample-cluster-stack --store default
