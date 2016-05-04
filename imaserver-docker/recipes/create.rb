#*******************************************************************************
#  Copyright (c) 2016 IBM Corporation and other Contributors.
# 
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  which accompanies this distribution, and is available at
#  http://www.eclipse.org/legal/epl-v10.html 
# 
#  Contributors:
#  IBM - Initial Contribution
#*******************************************************************************


#
# Cookbook Name:: imaserver-docker
# Recipe:: create_imaserver
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "docker"
# use init_type set['docker']['container_init_type'] = false

svtperf_container=node.default["svtperf-docker"]["imaserver"]["name"]
#build case/if of imaserver tiers (ie purples,green,etc) 
#which may have different settings for docke env file
template node.default["testhome"]+"/imaserver-docker.env" do
  source "imaserver-docker.env.erb"
  mode '0664'
  owner 'tester'
  group 'tester'
  variables({
     :memorySize => (node.default["svtperf-docker"]["imaserver"]["memory"]  / (1000*1000*1024)),
     :containerName => node.default["svtperf-docker"]["imaserver"]["name"],
     :adminPort => node.default["svtperf-docker"]["imaserver"]["admin-port"]
  })
end

Chef::Log.debug("create_imaserver: diag_dir: #{node.default["svtperf-docker"]["image"]["file"]}")

docker_image "svtperf-long-test" do
  input lazy {node.default["svtperf-docker"]["imaserver"]["image"]["file"]}
  action :load
end

Chef::Log.debug("create_imaserver: diag_dir: :#{node.default["svtperf-docker"]["imaserver"]["host_volume"]["diag"]}")

#create host diag  for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["diag"] do
    mode '0664'
    owner 'tester'
    group 'tester'
    recursive true
    action :create
end

#create host config for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["data"] do
    mode '0664'
    owner 'tester'
    group 'tester'
    recursive true
    action :create
end

#create host volume for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["store"] do
    mode '0664'
    owner 'tester'
    group 'tester'
    recursive true
    action :create
end

docker_container svtperf_container do
    image node.default["svtperf-docker"]["imaserver"]["image"]["name"]
    env_file node.default["testhome"]+"/imaserver-docker.env"
    net 'host'
    container_name svtperf_container

    publish_exposed_ports true

    volume [node.default["svtperf-docker"]["imaserver"]["diag"]+":"+node.default["svtperf-docker"]["imaserver"]["container_volume"]+"/diag",node.default["svtperf-docker"]["imaserver"]["data"]+":"+node.default["svtperf-docker"]["imaserver"]["container_volume"]+"/data",node.default["svtperf-docker"]["imaserver"]["store"]+":"+node.default["svtperf-docker"]["imaserver"]["container_volume"]+"/store"]

    #add 'g' for docker, but imaserver-docker.env doesnt need 'g'? otherwise add 'g' to attributes
    memory node.default["svtperf-docker"]["imaserver"]["memory"]
    init_type false
    tty true
    detach true
    action :run
end
