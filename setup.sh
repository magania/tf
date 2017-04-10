#! /bin/bash

CUDA_DOWNLOAD_LINK=https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
TENSORFLOW_WHEEL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.1.0rc1-cp34-cp34m-linux_x86_64.whl

# echo ${SSH_PUB_KEY} >> .ssh/authorized_keys

wget -Nc --show-progress ${CUDA_DOWNLOAD_LINK} -O cuda.run
chmod u+x cuda.run

sudo apt-get install -y gcc g++ python3 python3-dev python3-pip
sudo pip3 install --upgrade pip
sudo ./cuda.run --silent --toolkit
cd /usr/local/ && sudo tar xzf ~/${CUDNN_TGZ} && cd

sudo pip3 install --upgrade -r requirements.txt
sudo pip3 install --upgrade ${TENSORFLOW_WHEEL}

iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080

