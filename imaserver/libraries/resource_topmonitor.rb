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



require 'chef/resource'


class Chef
  class Resource
    class IMAServerTopicMonitor < Chef::Resource

      provides :imaserver_topicMonitor

      # need to support array of topics
      @@NAME_TYPE="TopicMonitor"


      #Current schema change...remove old types if tested and successful
      #@@ACTION_TYPE="Action"
      #@@USERID_TYPE="User"
      #@@STATTYPE_TYPE="StatType"
      #@@RESULTCOUNT_TYPE="ResultCount"
      #@@TOPICSTRING_TYPE="TopicString"      


      def initialize(name, run_context = nil)
        Chef::Log.debug("topicMonitor: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("topicMonitor: initialize")
        @resource_name = :imaserver_topicMonitor
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerTopicMonitor

        #default action
        @action = :create

        #define hub attrs
        @topic_names = name
        #old schema
        #@userid=nil
        #@stat_type=nil
        #@result_count=nil
        #@action="Topic" #should be always set to Topic

      end
"""
old schema
      #remove initial schema...remove all old schema code once confirmed and tested with new schema
      def ACTION_TYPE
        @@ACTION_TYPE
      end

      def USERID_TYPE
        @@USERID_TYPE
      end

      def STATTYPE_TYPE
        @@STATTYPE_TYPE
      end

      def RESULTCOUNT_TYPE
        @@RESULTCOUNT_TYPE
      end

      def TOPICSTRING_TYPE
        @@TOPICSTRING_TYPE
      end

      def userid(arg=nil)
        set_or_return(:topic,arg,:kind_of => String)
      end

      def stat_type(arg=nil)
        set_or_return(:common_names,arg,:kind_of =>String )
      end

      def result_count(arg=nil)
        set_or_return(:client_id,arg,:kind_of => String)
      end
      #end old schema code
end old schema
"""

      #array of topics
      def topic_names(arg=nil)
        set_or_return(:topic_names,arg,:kind_of => Array,:required => true)
      end


    end
  end
end
        
