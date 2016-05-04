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
    class IMAServerMsgPolicy < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerMsgPolicy provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerMsgPolicy.new(new_resource.policy_name)
        @current_resource.description(new_resource.description)
        @current_resource.policy_name(new_resource.policy_name)
        @current_resource.cert_common_names(new_resource.cert_common_names)
        @current_resource.client_id(new_resource.client_id)
        @current_resource.group_id(new_resource.group_id)
        @current_resource.client_addr(new_resource.client_addr)
        @current_resource.user_id(new_resource.user_id)
        @current_resource.protocol(new_resource.protocol)
        @current_resource.max_msgttl(new_resource.max_msgttl)
        @current_resource.max_msgs(new_resource.max_msgs)
        @current_resource.destination(new_resource.destination)
        @current_resource.destination_type(new_resource.destination_type)
        @current_resource.action_list(new_resource.action_list)
        @current_resource.max_msgsbehave(new_resource.max_msgsbehave)
        @current_resource.disconn_clientnotify(new_resource.disconn_clientnotify)

        Chef::Log.debug("IMAServerMsgPolicy provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerMsgPolicy provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.policy_name => {
              new_resource.DESCRIPTION_TYPE => new_resource.description, 
              new_resource.COMMONNAMES_TYPE => new_resource.cert_common_names,
              new_resource.CLIENTID_TYPE => new_resource.client_id,
              new_resource.GROUPID_TYPE => new_resource.group_id,
              new_resource.CLIENTADDRESS_TYPE => new_resource.client_addr,
              new_resource.USERID_TYPE => new_resource.user_id,
              new_resource.MAXMSGTTL => new_resource.max_msgttl,
              new_resource.PROTOCOL_TYPE => new_resource.protocol,
              new_resource.DESTINATION_TYPE => new_resource.destination,
              new_resource.DESTINATIONTYPE_TYPE => new_resource.destination_type,
              new_resource.ACTIONLIST_TYPE => new_resource.action_list,
              new_resource.MAXMSGS_TYPE => new_resource.max_msgs,
              new_resource.MAXMSGSBEHAVIOR_TYPE => new_resource.max_msgsbehave,
              new_resource.DISCONNCLIENTNOTIFY_TYPE => new_resource.disconn_clientnotify
            }}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("IMAServerMsgPolicy provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerMsgPolicy provider: json_payload: #{json_payload}")

        #add to admin class msgpolicy array
        @@msg_policies.insert(0,json_obj)
        new_resource.updated_by_last_action(true)

      end

      def action_post
        #setup message policies fourth
        @@msg_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: msg policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset msg_policies to empty array. 
        @@msg_policies=[]

      end
    end
  end
end
