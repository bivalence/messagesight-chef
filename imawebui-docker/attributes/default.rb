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
image_location="/mnt/builds/imawebui-dockerimage.tar"


# Add attributes for svtperf docker setup 
default["homedir"]="/home/deploy"

#setup vars according to environment
#memory is set to 8G in byte format
default["svtperf-docker"]["imawebui"]["memory"]=8182000000
default["svtperf-docker"]["imawebui"]["name"]="IMAWEBUI"
default["svtperf-docker"]["imawebui"]["imaserver"]["admin-port"]="9089"
default["svtperf-docker"]["imawebui"]["imaserver"]["ipAddress"]="127.0.0.1"
default["svtperf-docker"]["imawebui"]["port"]="9087"
#default["svtperf-docker"]["imawebui"]["host_volume"]="/mnt/messagesight"
#default["svtperf-docker"]["imawebui"]["container_volume"]="/var/messagesight"

default["svtperf-docker"]["imawebui"]["image"]["name"]="imawebui"
default["svtperf-docker"]["imawebui"]["image"]["file"]=image_location

