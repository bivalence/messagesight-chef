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
# Cookbook Name:: imaserver-rpm
# Recipe:: install
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Log.debug("imaserver-rpm: yum install server")
yum_package 'IBMIoTMessageSightServer'

execute "enable_IBMIoTMessageSightServer" do
  command 'systemctl enable IBMIoTMessageSightServer'
  timeout 10
end



