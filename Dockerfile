FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive \
  CUDA_HOME=/usr/local/cuda \
  CUDA_ARCH=sm_61 \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  PATH=/usr/local/cuda/bin:$PATH



RUN apt update && \
	  apt install -y  \
	  build-essential \
	  git \
	  wget \
	  vim \
	  python3 \
	  python3-dev \
	  python3-pip


COPY . ogc

RUN pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
RUN cd /ogc/pointnet2 && \
	TORCH_CUDA_ARCH_LIST="6.1 6.2 7.0 7.5 8.0 8.6" python3 setup.py install && \
    cd /ogc
RUN pip3 install -r /ogc/requirements.txt

WORKDIR /ogc

