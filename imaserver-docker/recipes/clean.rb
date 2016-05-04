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
# Recipe:: clean_imaserver
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "docker"
#include docker helper routines
::Chef::Recipe.send(:include, Docker::Helpers)

svtperf_image=node.default["svtperf-docker"]["imaserver"]["image"]["name"]
svtperf_container=node.default["svtperf-docker"]["imaserver"]["name"] 


docker_container  svtperf_container do 
  container_name svtperf_container
  init_type false
  action [:stop,:remove]
end

#Need to find list of images cause docker cookbook is too lazy providing
# a means to use wildcards for tag for removal of all tagged builds
#require 'docker/libraries/helpers'
image_list=docker_cmd("images",10)

Chef::Log.debug("Found list of all images: #{image_list.stdout}")

#parse array of strings for image name
image_matches=image_list.stdout.split(/\n/).select {|aimage| aimage.match(svtperf_image) }

Chef::Log.debug("Found matching images: #{image_matches}")

#remove matching images
image_matches.each do |aimage|
  #second element is tag
  tag_name=aimage.split(' ')[1]

  Chef::Log.debug("Removing tag: #{tag_name}")

  docker_image svtperf_image do
    tag tag_name
    action :remove
  end
end


