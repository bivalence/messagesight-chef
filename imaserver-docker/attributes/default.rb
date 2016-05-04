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


#setup local vars
top_directory="/mnt/seed/builds/release/CURREL/production"
buildname="docker-svtperf"
#build_ver="20151003-2347"

#demo build1
#build_ver="20151023-0418"
#demo build2
#build_ver="20151103-2311"

build_ver="latest"

default["testhome"]="/home/tester"

default["svtperf-docker"]["imaserver"]["memory"]=16384000000
default["svtperf-docker"]["imaserver"]["name"]="SVTPERF-IMASERVER"
default["svtperf-docker"]["imaserver"]["admin-port"]="9089"
default["svtperf-docker"]["imaserver"]["diag"]="/mnt/messagesight/diag"
default["svtperf-docker"]["imaserver"]["data"]="/mnt/messagesight/data"
default["svtperf-docker"]["imaserver"]["store"]="/var/messagesight/store"
default["svtperf-docker"]["imaserver"]["container_volume"]="/var/messagesight"

default["svtperf-docker"]["imaserver"]["image"]["name"]="imaserver-svtperf"
default["svtperf-docker"]["imaserver"]["image"]["file"]=top_directory+"/"+build_ver+"/"+buildname+"/imaserver-SVTPERF-DockerImage.tar"

