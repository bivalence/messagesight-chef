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
    class IMAServerTopicMonitor < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerTopicMonitor provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerTopicMonitor.new(new_resource.topic_names)

        #comment out old schema...delete if new schema is tested and works
"""
oldschmea
        @current_resource.userid(new_resource.userid)
        @current_resource.stat_type(new_resource.stat_type)
        @current_resource.result_count(new_resource.result_count)
        @current_resource.action(new_resource.action)
"""

        Chef::Log.debug("IMAServerTopicMonitor provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerTopicMonitor provider: action_create")

        #create json obj
        #topic monitor is a json array, therefore add brackets


"""
oldschema
              #comment out old schema...delete once tested and confirmed
              new_resource.USERID_TYPE => new_resource.userid,
              new_resource.ACTION_TYPE => new_resource.action,
              new_resource.STATTYPE_TYPE => new_resource.stat_type,
              new_resource.RESULTCOUNT_TYPE => new_resource.result_count
              new_resource.TOPICSTRING_TYPE => new_resource.topic_string,
              #end old schema

"""
        json_obj = {new_resource.NAME_TYPE =>
            (new_resource.topic_names.join(',') unless new_resource.topic_names)
            }

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("IMAServerTopicMonitor provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerTopicMonitor provider: json_payload: #{json_payload}")

        #add to admin class msgpolicy array
        @@topic_monitors.insert(0,json_obj)
        new_resource.updated_by_last_action(true)

      end

      def action_post

        #setup topic policies fifth
        @@topic_monitors.each do |amonitor|
          Chef::Log.debug("IMAServerTopicMonitor action post: topic monitors found: #{amonitor}")

          IMAServer::Helpers::Config.post(amonitor)
        end

        #if no errors reset topic_policies to empty array. 
        @@topic_monitors=[]

      end

    end
  end
end
