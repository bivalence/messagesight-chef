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
    class IMAServerLogLevel < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerLogLevel provider: load_current_resource: enter")


        @current_resource ||= Chef::Resource::IMAServerLogLevel.new(new_resource.level_name)
        @current_resource.level_name(new_resource.level_name)
        Chef::Log.debug("IMAServerLogLevel provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("loglevel provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => new_resource.level_name}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("loglevel provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("loglevel provider: json_payload: #{json_payload}")

        @@loglevel=json_obj
        new_resource.updated_by_last_action(true)
      end

      def action_post
        Chef::Log.debug("loglevel provider: action_post enter")

        IMAServer::Helpers::Config.post(@@loglevel)
        #if no errors reset admin_endpoint to nil. Otherwise admin provider will post
        #again since its actually IMAServerAdmin class var
        @@loglevel=nil

        Chef::Log.debug("loglevel provider: action_post exit")
      end
    end
end
end
