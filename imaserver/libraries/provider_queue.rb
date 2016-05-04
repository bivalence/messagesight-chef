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
    class IMAServerQueue < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerQueue provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerQueue.new(new_resource.queue_name)
        @current_resource.description(new_resource.description)
        @current_resource.queue_name(new_resource.queue_name)
        @current_resource.allow_send(new_resource.allow_send)
        @current_resource.concurr_consumers(new_resource.concurr_consumers)
        @current_resource.max_msgs(new_resource.max_msgs)

        Chef::Log.debug("IMAServerQueue provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("queue provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {new_resource.queue_name => {
              new_resource.DESCRIPTION_TYPE => new_resource.description,
              new_resource.ALLOWSEND_TYPE => new_resource.allow_send,
              new_resource.CONCURRENTCON_TYPE => new_resource.concurr_consumers,
              new_resource.MAXMSGS_TYPE => new_resource.max_msgs

            }}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("queue provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("queue provider: json_payload: #{json_payload}")

        @@queues.insert(0,json_obj)
        new_resource.updated_by_last_action(true)
      end

      def action_post
        #send post for each queue
        @@queues.each do |aqueue|
          Chef::Log.debug("IMAServerQueue action post: queue found: #{aqueue}")

          IMAServer::Helpers::Config.post(aqueue)
        end

        #if no errors reset queues to empty array. 
        @@queues=[]

      end
  end
end
end
