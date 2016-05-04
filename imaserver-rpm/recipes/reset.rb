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
# Cookbook Name:: imaserver-rpm
# Recipe:: reset
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Log.debug("imaserver-rpm: reseting server")

include_recipe 'imaserver-rpm::stop'
#cleanup host volume directories
#create host diag  for msserver 
directory node.default["imaserver-rpm"]["imaserver"]["diag"] do
  recursive true
  action :delete
end

directory node.default["imaserver-rpm"]["imaserver"]["diag"] do
  action :create
end

directory node.default["imaserver-rpm"]["imaserver"]["data"] do
  recursive true
  action :delete
end

directory node.default["imaserver-rpm"]["imaserver"]["data"] do
  action :create
end

#create host volume for msserver 
directory node.default["imaserver-rpm"]["imaserver"]["store"] do
  recursive true
  action :delete
end

directory node.default["imaserver-rpm"]["imaserver"]["store"] do
  action :create
end

#for now re-install until start scripts recognize a reset
include_recipe 'imaserver-rpm::uninstall'
include_recipe 'imaserver-rpm::install'

#during reset we need to recreate messagesight dirs
#msserver should be cleaned up. restart container
include_recipe "imaserver-rpm::start"
