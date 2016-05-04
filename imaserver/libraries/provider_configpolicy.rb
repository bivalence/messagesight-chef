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
    class IMAServerConfigurationPolicy < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerConfigurationPolicy provider: load_current_resource: enter")

        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerConfigurationPolicy.new(new_resource.config_name)
        @current_resource.description(new_resource.description)
        @current_resource.config_name(new_resource.config_name)
        @current_resource.cert_common_names(new_resource.cert_common_names)
        @current_resource.group_id(new_resource.group_id)
        @current_resource.client_addr(new_resource.client_addr)
        @current_resource.user_id(new_resource.user_id)
        @current_resource.action_list(new_resource.action_list)


        Chef::Log.debug("IMAServerConfigurationPolicy provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerConfigurationPolicy hub provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.config_name => {new_resource.DESCRIPTION_TYPE => new_resource.description,
              new_resource.COMMONNAMES_TYPE=> new_resource.cert_common_names,
              new_resource.GROUPID_TYPE=> new_resource.group_id,
              new_resource.CLIENTADDRESS_TYPE=> new_resource.client_addr,
              new_resource.USERID_TYPE => new_resource.user_id,
              new_resource.ACTIONLIST_TYPE => new_resource.action_list,
            }}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("IMAServerConfigurationPolicy provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerConfigurationPolicy provider: json_payload: #{json_payload}")

        #add to admin class endpoints array
        @@config_policies.insert(0,json_obj)

        new_resource.updated_by_last_action(true)

      end

      def action_post
        Chef::Log.debug("IMAServerConfigPolicy provider: action_post enter")

        #setup config policies nineth
        @@config_policies.each do |apolicy|
          Chef::Log.debug("IMAServerConfigPolicy action post: configiuration policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset config_policies to nil. 
        #Otherwise admin provider will post
        #again since its actually IMAServerAdmin class var
        @@config_policies=[]
        Chef::Log.debug("IMAServerConfigPolicy provider: action_post exit")
      end

    end
  end
end
