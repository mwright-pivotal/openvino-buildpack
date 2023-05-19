# openvino-buildpack

install docker on linux
download pack cli from buildpacks.io


# Build the stack

```console
cd ../
export MYREG=myregistry.com
docker build -t ${MYREG}/openvino-stack-base:jammy --target base . -f Dockerfile-openvino-stack-jammy
docker build -t ${MYREG}/openvino-stack-run:jammy --target run . -f Dockerfile-openvino-stack-jammy
docker build -t ${MYREG}/openvino-stack-build:jammy --target build . -f Dockerfile-openvino-stack-jammy

docker push ${MYREG}/openvino-stack-base:jammy
docker push ${MYREG}/openvino-stack-run:jammy
docker push ${MYREG}/openvino-stack-build:jammy
```

# Create the builder

Modify builder-jammy to reference your run and build container locations
```console
pack builder create openvino-builder:jammy --config ./builder-jammy.toml -v
```

# KPack/Tanzu Build Service (optional)

if you are using Kpack or Tanzu Build Service, you need to create a CustomStack and custom ClusterBuilder inside your target kubernetes cluster where kpack is deployed.
1. edit OpenvinoCustomStack.yaml to point to your built images for build and run, you must use the sha references to the images
2. kubectl apply -f OpenvinoCustomStack.yaml
3. use KPAck cli to create a custom ClusterBuilder:  kp clusterbuilder create openvino-builder --tag harbor.services.edge.wrightcode.io:9443/library/openvino-builder:1.0.0 --stack computer-vision-cluster-stack --store default
