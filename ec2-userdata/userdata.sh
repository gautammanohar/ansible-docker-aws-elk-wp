#!/bin/bash
ANSIBLE_BUCKET="ansible-gautam"
EC2_SSH_KEY="n-virginia-temp.pem"
CREDENTIALS_FILE="credentials"

# python locale issues
echo "export LC_ALL=en_US.UTF-8" >> /root/.bashrc
echo "export LANG=en_US.UTF-8" >> /root/.bashrc
echo "export LANGUAGE=en_US.UTF-8" >> /root/.bashrc
source /root/.bashrc


# install pip and other dependencies
apt-get update
apt-get install -y python-pip python-yaml python-paramiko python-jinja2 python-httplib2 gcc libssl-dev libffi-dev
pip install --upgrade pip

# install molecule
pip install molecule

# install docker driver
pip install docker

# install boto/boto3
pip install boto
pip install boto3

# install aws cli
pip install awscli

# install docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-cache policy docker-engine
apt-get install -y docker-engine

# install ansible
wget http://releases.ansible.com/ansible/ansible-2.2.1.0.tar.gz
tar -xvf ansible-2.2.1.0.tar.gz
cd ansible-2.2.1.0
make && sudo make install

# Download the ansible configuration file
mkdir -p /etc/ansible/keys
aws s3 cp s3://$ANSIBLE_BUCKET/ansible.cfg /etc/ansible/ansible.cfg

# copy the ssh keys to ssh into new instances
aws s3 cp s3://$ANSIBLE_BUCKET/$EC2_SSH_KEY /etc/ansible/keys/$EC2_SSH_KEY
chmod 700 /etc/ansible/keys/$EC2_SSH_KEY

# copy the aws credentials
mkdir /root/.aws
aws s3 cp s3://$ANSIBLE_BUCKET/$CREDENTIALS_FILE /root/.aws/$CREDENTIALS_FILE

# clone the playbook repo
cd /home
git clone https://github.com/gautammanohar/ansible-docker-aws-elk-wp.git
