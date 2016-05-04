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
    class IMAServerTopicPolicy < Chef::Resource

      provides :imaserver_topicPolicy

      @@NAME_TYPE="TopicPolicy"
      @@DESCRIPTION_TYPE="Description"
      @@COMMONNAMES_TYPE="CommonNames"
      @@CLIENTID_TYPE="ClientID"
      @@GROUPID_TYPE="GroupID"
      @@CLIENTADDRESS_TYPE="ClientAddress"
      @@USERID_TYPE="UserID"
      @@MAXMSGTTL="MaxMessageTimeToLive"
      @@PROTOCOL_TYPE="Protocol"
      @@TOPIC_TYPE="Topic"
      @@ACTIONLIST_TYPE="ActionList"
      @@MAXMSGS_TYPE="MaxMessages"
      @@MAXMSGSBEHAVIOR_TYPE="MaxMessagesBehavior"
      @@MAXMSGTTL_TYPE="MaxMessageTimeToLive"
      @@DISCONNCLIENTNOTIFY_TYPE="DisconnectedClientNotification"


      def initialize(name, run_context = nil)
        Chef::Log.debug("topicPolicy: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("topicPolicy: initialize")
        @resource_name = :imaserver_topicPolicy
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerTopicPolicy

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @policy_name = name
        @topic=nil
        @cert_common_names=nil
        @client_id=nil
        @group_id=nil
        @client_addr=nil
        @user_id=nil
        @protocol=nil
        @max_msgttl=nil
        @max_msgs=0  
        @action_list=nil
        @max_msgsbehave=nil
        @disconn_clientnotify=false

      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def COMMONNAMES_TYPE
        @@COMMONNAMES_TYPE
      end

      def TOPIC_TYPE
        @@TOPIC_TYPE
      end

      def CLIENTID_TYPE
        @@CLIENTID_TYPE
      end

      def GROUPID_TYPE
        @@GROUPID_TYPE
      end

      def CLIENTADDRESS_TYPE
        @@CLIENTADDRESS_TYPE
      end

      def USERID_TYPE
        @@USERID_TYPE
      end

      def MAXMSGTTL
        @@MAXMSGTTL
      end

      def PROTOCOL_TYPE
        @@PROTOCOL_TYPE
      end

      def ACTIONLIST_TYPE
        @@ACTIONLIST_TYPE
      end

      def MAXMSGS_TYPE
        @@MAXMSGS_TYPE
      end

      def MAXMSGSBEHAVIOR_TYPE
        @@MAXMSGSBEHAVIOR_TYPE
      end

      def MAXMSGTTL_TYPE
        @@MAXMSGTTL_TYPE
      end

      def DISCONNCLIENTNOTIFY_TYPE
        @@DISCONNCLIENTNOTIFY_TYPE
      end

      def PENDINGACTION_TYPE
        @@PENDINGACTION_TYPE
      end

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def policy_name(arg=nil)
        set_or_return(:policy_name,arg,:kind_of => String)
      end

      def topic(arg=nil)
        set_or_return(:topic,arg,:kind_of => String)
      end

      def cert_common_names(arg=nil)
        set_or_return(:common_names,arg,:kind_of =>String )
      end

      def client_id(arg=nil)
        set_or_return(:client_id,arg,:kind_of => String)
      end

      def group_id(arg=nil)
        set_or_return(:group_id,arg,:kind_of =>String )
      end

      def client_addr(arg=nil)
        set_or_return(:client_addr,arg,:kind_of =>String )
      end

      def user_id(arg=nil)
        set_or_return(:userid,arg,:kind_of =>String )
      end

      def protocol(arg=nil)
        set_or_return(:protocol,arg,:kind_of =>String )
      end

      def max_msgttl(arg=nil)
        set_or_return(:max_msgttl,arg,:kind_of =>String )
      end

      def max_msgs(arg=nil)
        set_or_return(:max_msgs,arg,:kind_of =>Integer )
      end

      def action_list(arg=nil)
        set_or_return(:action_list,arg,:kind_of =>String )
      end

      def max_msgsbehave (arg=nil)
        set_or_return(:max_msgsbehave,arg,:kind_of => String)
      end

      def disconn_clientnotify(arg=nil)
        set_or_return(:disconn_clientnotify,arg,:kind_of => [TrueClass,FalseClass])
      end

    end
  end
end
        
