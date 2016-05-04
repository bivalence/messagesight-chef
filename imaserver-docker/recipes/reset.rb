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
# Recipe:: reset
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

#stop container before removing/cleaning up config,diag and data directories
include_recipe "imaserver-docker::stop"


#cleanup host volume directories
#create host diag  for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["diag"] do
  recursive true
  action :delete
end

#create host config for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["data"] do
  recursive true
  action :delete
end

#create host volume for imaserver 
directory node.default["svtperf-docker"]["imaserver"]["store"] do
  recursive true
  action :delete
end

#imaserver should be cleaned up. restart container
include_recipe "imaserver-docker::start"
