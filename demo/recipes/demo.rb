#
# Cookbook Name:: demo
# Recipe:: demo
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'imaserver'


#these attributes should exist and created during node creation
cluster_group='chef-cluster-group'
cluster_discovery_port=7104
cluster_cntrl_port=10101
cluster_msg_port=10102
cluster_cntrl_addr='222.222.222.222'
cluster_msg_addr='111.111.111.111'

"""
test admin endpoint to use localhost
"""

#quickly test default setting of admin endpoint
imaserver_admin '127.0.0.1' do
  Chef::Log.debug("gonna try test to localhost")
   port 9089
   action   :test
end


"""
setup a glob of  config objects. After creating all config objects
perform a post to upload all created config objects
"""

#create an endpoint now to show config resources can be placed anywhere
#between 'imaserver_admin' resources. 'imaserver_admin' with action post
#will take care of order automatically
imaserver_endpoint 'ChefEndpoint3' do
  description 'chef endpoint3'
  msg_hub 'Chef3 Hub'
  conn_policies ['ChefConnectionPolicy']
  topic_policies ['ChefSubTopicPolicy','ChefPubTopicPolicy']
  subscription_policies ['ChefRecvSubPolicy','ChefCntrlSubPolicy']

  port 16103
  max_sendsz 20000
  max_msgsz '4096KB'
  interface "All"
  batch_msgs false
  enable true
  protocol "MQTT"
end

#create hubs
imaserver_hub 'Chef Hub' do
   description 'chef created hub!!'
   action :create
end

%w{Chef2 Chef3}.each do |hubtype|
  imaserver_hub "#{hubtype} Hub" do
    description "#{hubtype} Hub 2"
    action  :create
  end
end

#create connection policy
imaserver_connPolicy 'ChefConnectionPolicy' do
  description "Chef Connection policy"
  allow_persist_msg true
  cert_common_names "*"
  client_id "*"
  group_id "*"
  client_addr "*"
  user_id "*"
  protocol "JMS,MQTT"
  allow_durable true
end

#create topic policy for publish
imaserver_topicPolicy 'ChefPubTopicPolicy' do
  description 'Chef topic policy'
  topic '*'
  cert_common_names '*'
  client_id "*"
  group_id "*"
  client_addr "*"
  user_id "*"
  protocol "JMS,MQTT"
  max_msgs 500
  max_msgttl "6000"
  disconn_clientnotify true
  max_msgsbehave "RejectNewMessages"
  action_list "Publish,Subscribe"
end

#create topic policy for subscription
imaserver_topicPolicy 'ChefSubTopicPolicy' do
  description 'Another Chef topic policy'
  topic '/CHEF_TOPIC2/*'
  cert_common_names 'mycommonnames'
  client_id "u00000021"
  group_id "g00000001"
  client_addr "10.24.1.100"
  user_id "tom"
  protocol "JMS,MQTT"
  max_msgs 500
  max_msgttl "6000"
  max_msgsbehave "RejectNewMessages"
  disconn_clientnotify true
  action_list "Subscribe"
end

#create subscription policy
imaserver_subscriptionPolicy 'ChefRecvSubPolicy' do
  description 'subscription policy'
  subscription '/CHEF_SUBSCRIPTION/*'
  cert_common_names 'mycommonnames'
  client_id "u00000030"
  group_id "g00000001"
  client_addr "10.24.1.100"
  user_id "tom"
  protocol "JMS"
  max_msgs 500
  max_msgsbehave "RejectNewMessages"
  action_list "Receive"
end

#create subscription policy
imaserver_subscriptionPolicy 'ChefCntrlSubPolicy' do
  description 'another subscription policy'
  subscription '/CHEF_SUBSCRIPTION/*'
  cert_common_names 'mycommonnames'
  client_id "u00000031"
  group_id "g00000001"
  client_addr "10.24.1.100"
  user_id "tom"
  protocol "JMS"
  max_msgs 500
  max_msgsbehave "RejectNewMessages"
  action_list "Control"
end

#create an endpoint
imaserver_endpoint 'ChefEndpoint' do
  description 'chef endpoint'
  msg_hub 'Chef Hub'
  conn_policies ['ChefConnectionPolicy']
  topic_policies ['ChefPubTopicPolicy']

  port 16101
  max_sendsz 20000
  max_msgsz '4096KB'
  interface "All"
  batch_msgs false
  enable true
  protocol "MQTT"

end

#create an endpoint
imaserver_endpoint 'ChefEndpoint2' do
  description 'chef endpoint2'
  msg_hub 'Chef2 Hub'
  conn_policies ['ChefConnectionPolicy']
  topic_policies ['ChefSubTopicPolicy','ChefPubTopicPolicy']
  subscription_policies ['ChefCntrlSubPolicy']

  port 16102
  max_sendsz 20000
  max_msgsz '4096KB'
  interface "All"
  batch_msgs false
  enable true
  protocol "MQTT"
end


#create a queue
imaserver_queue 'Chef Queue' do
  description 'a chef queue'
  allow_send true
  concurr_consumers false
  max_msgs 10000
end

#create 2 queues
%w{Chef2 Chef3}.each do |qtype|
  imaserver_queue "#{qtype} Queue" do
    description "a #{qtype} queue"
    allow_send true
    concurr_consumers false
    max_msgs 10000
  end
end

#create a queue policy
imaserver_queuePolicy 'ChefQueuePolicy' do
  description 'my queue policy'
  queue 'Chef Queue'
  cert_common_names 'acertname'
  client_id "u00000040"
  group_id "g00000001"
  client_addr "10.24.1.100"
  user_id "tom"
  protocol "JMS"
  max_msgttl "6000"
  action_list "Send"
end

#create an endpoint
imaserver_endpoint 'ChefEndpoint4' do
  description 'chef endpoint4 for queue'
  msg_hub 'Chef3 Hub'
  conn_policies ['ChefConnectionPolicy']
  queue_policies ['ChefQueuePolicy']
  port 16104
  max_sendsz 20000
  max_msgsz '4096KB'
  interface "All"
  batch_msgs false
  enable true
  protocol "MQTT"
end

#create a cluster
imaserver_cluster cluster_group do
  enable_membership  true
  multicast_discovery true
  discovery_port cluster_discovery_port
  multicast_ttl 16
  control_addr cluster_cntrl_addr
  control_port cluster_cntrl_port
  msg_addr cluster_msg_addr
  msg_port cluster_msg_port
end


#push out all config objects created and restart server for cluster settings
imaserver_admin '127.0.0.1' do
  Chef::Log.debug("posting config")
  port 9089
  action  [:post,:restart]
end


