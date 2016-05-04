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
#
# Cookbook Name:: imawebui-rpm
# Recipe:: install
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Log.debug("imawebui-rpm: yum install webui")
yum_package 'IBMIoTMessageSightWebUI'

execute "enable_IBMIoTMessageSightWebUI" do
  command 'systemctl enable IBMIoTMessageSightWebUI'
  timeout 10
end
