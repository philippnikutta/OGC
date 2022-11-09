FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive \
  CUDA_HOME=/usr/local/cuda-11.1 \
  CUDA_ARCH=sm_111 \
  LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64:$LD_LIBRARY_PATH \
  PATH=/usr/local/cuda-11.1/bin:$PATH


# Set default shell to /bin/bash
SHELL ["/bin/bash", "-cu"]

RUN apt update && \
	  apt install -y  \
	  g++-4.8 \
	  git \
	  wget \
	  vim \
	  python \
	  python3-pip


COPY . ogc

RUN pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
RUN cd /ogc/pointnet2 && \
	python3 setup.py install && \
    cd /ogc
RUN pip3 install -r requirements.txt

WORKDIR /ogc
CMD ["bash"]

