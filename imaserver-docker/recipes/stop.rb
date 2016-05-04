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
# Recipe:: stop
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "docker"

#docker_container "svtperf-long-test" do
docker_container   node.default["svtperf-docker"]["imaserver"]["name"] do
    container_name node.default["svtperf-docker"]["imaserver"]["name"]
    init_type false
    action :stop
end
