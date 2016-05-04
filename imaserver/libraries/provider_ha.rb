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
   class IMAServerAdmin
    class IMAServerHA < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerHub provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerHA.new(new_resource.group_name)
        @current_resource.enable(new_resource.enable)
        @current_resource.primary(new_resource.primary)
        @current_resource.local_replication(new_resource.local_replication)
        @current_resource.local_discovery(new_resource.local_discovery)
        @current_resource.remote_discovery(new_resource.remote_discovery)
        @current_resource
      end

      def action_create
        Chef::Log.debug("ha provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {
            new_resource.GROUP_TYPE => new_resource.group_name,
            new_resource.ENABLE_TYPE => new_resource.enable,
            new_resource.PRIMARY_TYPE => new_resource.primary,
            new_resource.LOCALREPLICATION_TYPE => new_resource.local_replication,
            new_resource.LOCALDISCOVERY_TYPE => new_resource.local_discovery,
            new_resource.REMOTEDISCOVERY_TYPE => new_resource.remote_discovery,

          }}

        Chef::Log.debug("ha provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("ha provider: json_payload: #{json_payload}")

        @@ha=json_obj
        new_resource.updated_by_last_action(true)
      end

      def action_post
        #setup ha
        if @@ha
          Chef::Log.debug("IMAServerAdmin action post: ha found: #{@@ha}")

          IMAServer::Helpers::Config.post(@@ha)
        end

        #if no errors reset ha to nil. 
        @@ha=nil

      end
    end
  end
end
end

