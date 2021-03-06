#############################################################
##	This is the utility script to setup a user for hadoop and
##	public key access to localhost in a Ec2 Ubuntu instance
#############################################################
ssh -i <key_file_path> ubuntu@<ip_address>
# Create password for root
sudo passwd
su root
# as [root]
echo "<host_name>" > /etc/hostname
grep -q '<host_name>' /etc/hosts && sed -i "/<host_name>/c\<ip>\t<host_name>/" /etc/hosts || echo -e '<ip>\t<host_name>' >> /etc/hosts

mkdir /root/.ssh
touch authorized_keys
cat /home/ubuntu/.ssh/authorized_keys > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
exit


ssh -i <key_file_path> root@<ip_address>
# as [root]
groupadd hadoop
useradd -g hadoop -m hadoop -s /bin/bash
passwd hadoop
mkdir /home/hadoop/.ssh
touch /home/hadoop/.ssh/authorized_keys
cat /home/ubuntu/.ssh/authorized_keys > /home/hadoop/.ssh/authorized_keys
more /home/hadoop/.ssh/authorized_keys
ls -la /home/hadoop/.ssh
chown -R hadoop:hadoop /home/hadoop/.ssh
ls -la /home/hadoop/.ssh
exit



scp -i <key_file_path> <key_file_path> hadoop@<host_name>:/home/hadoop/.ssh/
ssh -i <key_file_path> hadoop@<ip_address>
touch ~/.ssh/config
chmod 600 ~/.ssh/config
echo "Host localhost" > ~/.ssh/config
echo "IdentityFile ~/.ssh/<key_file_name>" >> ~/.ssh/config
echo "Host <host_name>" >> ~/.ssh/config
echo "IdentityFile ~/.ssh/<key_file_name>" >> ~/.ssh/config

ssh localhost
ssh <host_name>

# From Client
#ssh -i <key_file_path> hadoop@<ip_address>
#ls -la /home/hadoop/.ssh
#chmod 600 /home/hadoop/.ssh/authorized_keys
#ls -la /home/hadoop/.ssh
#ssh-keygen
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#ssh hadoop@localhost
#exit
#exit



