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
    class IMAServerConnPolicy < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerConnPolicy provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerConnPolicy.new(new_resource.policy_name)
        @current_resource.description(new_resource.description)
        @current_resource.policy_name(new_resource.policy_name)
        @current_resource.allow_persist_msg(new_resource.allow_persist_msg)
        @current_resource.cert_common_names(new_resource.cert_common_names)
        @current_resource.client_id(new_resource.client_id)
        @current_resource.group_id(new_resource.group_id)
        @current_resource.client_addr(new_resource.client_addr)
        @current_resource.user_id(new_resource.user_id)
        @current_resource.protocol(new_resource.protocol)
        @current_resource.allow_durable(new_resource.allow_durable)

        Chef::Log.debug("IMAServerConnPolicy provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerConnPolicy provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.policy_name => {
              new_resource.DESCRIPTION_TYPE => new_resource.description,
              new_resource.ALLOWEDPERSISTMSG_TYPE => new_resource.allow_persist_msg,
              new_resource.COMMONNAMES_TYPE => new_resource.cert_common_names,
              new_resource.PROTOCOL_TYPE => new_resource.protocol,
              new_resource.CLIENTID_TYPE => new_resource.client_id,
              new_resource.GROUPID_TYPE => new_resource.group_id,
              new_resource.CLIENTADDRESS_TYPE => new_resource.client_addr,
              new_resource.USERID_TYPE =>  new_resource.user_id,
              new_resource.ALLOWDURABLE_TYPE => new_resource.allow_durable

            }}}

        #remove nil and empty hash's
        json_obj.compact


        Chef::Log.debug("IMAServerConnPolicy provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerConnPolicy provider: json_payload: #{json_payload}")
        new_resource.updated_by_last_action(true)

        #add conn policy to connpolicy array
        @@conn_policies.insert(0,json_obj)
      end

      def action_post

        #setup connection policies third
        @@conn_policies.each do |apolicy|
          Chef::Log.debug("IMAServerConnPolicy action post: conn policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset conn_policies to empty array. 
        @@conn_policies=[]

      end
    end
  end
end
