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
    class IMAServerEndpoint < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerEndpoint provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerEndpoint.new(new_resource.endpoint_name)
        @current_resource.description(new_resource.description)
        @current_resource.endpoint_name(new_resource.endpoint_name)
        @current_resource.sec_profile(new_resource.sec_profile)
        @current_resource.msg_hub(new_resource.msg_hub)
        @current_resource.max_sendsz(new_resource.max_sendsz)
        @current_resource.max_msgsz(new_resource.max_msgsz)
        @current_resource.enable(new_resource.enable)
        @current_resource.batch_msgs(new_resource.batch_msgs)
        @current_resource.port(new_resource.port)
        @current_resource.protocol(new_resource.protocol)
        @current_resource.interface(new_resource.interface)
        @current_resource.interface_name(new_resource.interface_name)
        @current_resource.conn_policies(new_resource.conn_policies)
        @current_resource.topic_policies(new_resource.topic_policies)
        @current_resource.queue_policies(new_resource.queue_policies)
        @current_resource.subscription_policies(new_resource.subscription_policies)

        Chef::Log.debug("IMAServerEndpoint provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerEndpoint hub provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.endpoint_name => {new_resource.DESCRIPTION_TYPE => new_resource.description,
              new_resource.SECPROFILE_TYPE => new_resource.sec_profile,
              new_resource.MSGHUB_TYPE => new_resource.msg_hub,
              new_resource.MAXSENDSZ_TYPE => new_resource.max_sendsz,
              new_resource.MAXMSGSZ_TYPE => new_resource.max_msgsz,
              new_resource.ENABLE_TYPE => new_resource.enable,
              new_resource.BATCHMSGS_TYPE => new_resource.batch_msgs,
              new_resource.PORT_TYPE => new_resource.port,
              new_resource.PROTOCOL_TYPE => new_resource.protocol,
              new_resource.INTERFACE_TYPE => new_resource.interface,
              new_resource.CONNPOLICIES_TYPE => (new_resource.conn_policies.join(',') if new_resource.conn_policies),
              new_resource.TOPICPOLICIES_TYPE => (new_resource.topic_policies.join(',') if new_resource.topic_policies),
              new_resource.QUEUEPOLICIES_TYPE => (new_resource.queue_policies.join(',') if new_resource.queue_policies),
              new_resource.SUBSCRIPTIONPOLICIES_TYPE => (new_resource.subscription_policies.join(',') if new_resource.subscription_policies),

            }}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("IMAServerEndpoint provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerEndpoint provider: json_payload: #{json_payload}")

        #add to admin class endpoints array
        @@endpoints.insert(0,json_obj)

        new_resource.updated_by_last_action(true)

      end

      def action_post

        #setup endpoints eighth
        @@endpoints.each do |aendpoint|
          Chef::Log.debug("IMAServerEndpoint action post: endpoints found: #{aendpoint}")

          IMAServer::Helpers::Config.post(aendpoint)
        end

        #if no errors reset endpoints to empty array. 
        @@endpoints=[]

      end
    end
  end
end
