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


#setup location of docker image to use
image_location="/mnt/builds/imaserver-dockerimage.tar"



#setup var where template msserver-docker.env.erb output will reside used in create.rb recipe
default["homedir"]="/home/deploy"

#setup vars according to environment
#memory is set to 16G in byte format
default["svtperf-docker"]["imaserver"]["memory"]=16384000000
default["svtperf-docker"]["imaserver"]["name"]="IMASERVER"
default["svtperf-docker"]["imaserver"]["admin-port"]="9089"
default["svtperf-docker"]["imaserver"]["diag"]="/mnt/messagesight/diag"
default["svtperf-docker"]["imaserver"]["data"]="/mnt/messagesight/data"
default["svtperf-docker"]["imaserver"]["store"]="/var/messagesight/store"
default["svtperf-docker"]["imaserver"]["container_volume"]="/var/messagesight"

default["svtperf-docker"]["imaserver"]["image"]["name"]="imaserver"
default["svtperf-docker"]["imaserver"]["image"]["file"]=image_location

