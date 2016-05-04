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
# Cookbook Name:: imawebui-docker
# Recipe:: create
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "docker"
# use init_type set['docker']['container_init_type'] = false

#build case/if of imaserver tiers (ie purples,green,etc) 
#which may have different settings for docke env file
template node.default["testhome"]+"/imawebui-docker.env" do
  source "imawebui-docker.env.erb"
  mode '0664'
  owner 'tester'
  group 'tester'
  variables({
     :memorySize => node.default["svtperf-docker"]["imawebui"]["memory"],
     :containerName => node.default["svtperf-docker"]["imawebui"]["name"],
     :imaserver_adminPort => node.default["svtperf-docker"]["imawebui"]["imaserver"]["admin-port"],
     :imaserver_ipAddress => node.default["svtperf-docker"]["imawebui"]["imaserver"]["ipAddress"],
     :imawebui_port => node.default["svtperf-docker"]["imawebui"]["port"],

  })
end

Chef::Log.debug("create_imawebui: diag_dir: #{node.default["svtperf-docker"]["image"]["file"]}")

docker_image "svtperf-long-test" do
  input lazy {node.default["svtperf-docker"]["imawebui"]["image"]["file"]}
  action :load
end


docker_container "svtperf-long-test" do
    image node.default["svtperf-docker"]["imawebui"]["image"]["name"]
    env_file node.default["testhome"]+"/imawebui-docker.env"
    net 'host'
    container_name node.default["svtperf-docker"]["imawebui"]["name"]
    publish_exposed_ports true

    #add 'g' for docker, but imaserver-docker.env doesnt need 'g'? otherwise add 'g' to attributes
    memory node.default["svtperf-docker"]["imawebui"]["memory"]
    init_type false
    tty true
    detach true
    action :run
end
