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
docker build -t ${MYREG}/openvino-stack-base:bionic --target base . -f Dockerfile-openvino-stack
docker build -t ${MYREG}/openvino-stack-run:bionic --target run . -f Dockerfile-openvino-stack
docker build -t ${MYREG}/openvino-stack-build:bionic --target build . -f Dockerfile-openvino-stack

docker push ${MYREG}/openvino-stack-base:bionic
docker push ${MYREG}/openvino-stack-run:bionic
docker push ${MYREG}/openvino-stack-build:bionic
```

# Create the builder

```console
pack builder create openvino-builder:bionic --config ./builder.toml -v
```