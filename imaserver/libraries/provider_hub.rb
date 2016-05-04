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



class Chef
  class Provider
    class IMAServerHub < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerHub provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerHub.new(new_resource.hub_name)
        @current_resource.description(new_resource.description)
        @current_resource.hub_name(new_resource.hub_name)
        Chef::Log.debug("IMAServerHub provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("hub provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.hub_name => {
              new_resource.DESCRIPTION_TYPE => new_resource.description}}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("hub provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("hub provider: json_payload: #{json_payload}")

        @@hubs.insert(0,json_obj)
        new_resource.updated_by_last_action(true)
      end

      def action_post
        #send post for each hub
        @@hubs.each do |ahub|
          Chef::Log.debug("IMAServerHub action post: hub found: #{ahub}")

          IMAServer::Helpers::Config.post(ahub)
        end

        #if no errors reset hubs to empty array. 
        @@hubs=[]

      end
    end
end
end
