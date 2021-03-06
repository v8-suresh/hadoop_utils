# Seconmdary Name node configuration
# Assumption is Hadoop is already configured and setup in secondary namenode machine
#	  (https://github.com/v8-suresh/hadoop_utils/blob/master/100_setup_user_acc.sh)
#     (https://github.com/v8-suresh/hadoop_utils/blob/master/101_install_java_hadoop.sh)
# Login to namenode
ssh -i <key_file_path> hadoop@<namenode_host_name>
more $HADOOP_CONF_DIR/masters
echo "<sec_namenode_host_name>" > $HADOOP_CONF_DIR/masters
more /etc/hosts
su root
grep -q '<sec_namenode_host_name>' /etc/hosts && sed -i "/<sec_namenode_host_name>/c\<sec_namenode_ip>\t<sec_namenode_host_name>/" /etc/hosts || echo -e '<sec_namenode_ip>\t<sec_namenode_host_name>' >> /etc/hosts
# For password less login from namenode to secondary namenode
echo "Host <sec_namenode_host_name>" >> ~/.ssh/config
echo "IdentityFile ~/.ssh/<key_file_name>" >> ~/.ssh/config
ssh <sec_namenode_host_name>

# rsync conf from namenode to secondary namenode
rsync -avz -e "ssh" "$HADOOP_CONF_DIR/" "hadoop@<sec_namenode_host_name>:$HADOOP_CONF_DIR/"
exit

#	Login to Secondary namenode
ssh -i <key_file_path> hadoop@<sec_namenode_host_name>
su root
grep -q '<namenode_host_name>' /etc/hosts && sed -i "/<namenode_host_name>/c\<namenode_ip>\t<sec_namenode_host_name>/" /etc/hosts || echo -e '<namenode_ip>\t<namenode_host_name>' >> /etc/hosts
grep -q '<sec_namenode_host_name>' /etc/hosts && sed -i "/<sec_namenode_host_name>/c\<sec_namenode_ip>\t<sec_namenode_host_name>/" /etc/hosts || echo -e '<sec_namenode_ip>\t<sec_namenode_host_name>' >> /etc/hosts

