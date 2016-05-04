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
    class IMAServerSubscriptionPolicy < Chef::Resource

      provides :imaserver_subscriptionPolicy

      @@NAME_TYPE="SubscriptionPolicy"
      @@DESCRIPTION_TYPE="Description"
      @@COMMONNAMES_TYPE="CommonNames"
      @@CLIENTID_TYPE="ClientID"
      @@GROUPID_TYPE="GroupID"
      @@CLIENTADDRESS_TYPE="ClientAddress"
      @@USERID_TYPE="UserID"
      @@MAXMSGTTL="MaxMessageTimeToLive"
      @@PROTOCOL_TYPE="Protocol"
      @@SUBSCRIPTION_TYPE="Subscription"
      @@ACTIONLIST_TYPE="ActionList"
      @@MAXMSGS_TYPE="MaxMessages"
      @@MAXMSGSBEHAVIOR_TYPE="MaxMessagesBehavior"


      def initialize(name, run_context = nil)
        Chef::Log.debug("subscriptionPolicy: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("subscriptionPolicy: initialize")
        @resource_name = :imaserver_subscriptionPolicy
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerSubscriptionPolicy

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @policy_name = name
        @subscription=nil
        @cert_common_names=nil
        @client_id=nil
        @group_id=nil
        @client_addr=nil
        @user_id=nil
        @protocol=nil
        @max_msgs=0
        @action_list=nil
        @max_msgsbehave=nil


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

      def SUBSCRIPTION_TYPE
        @@SUBSCRIPTION_TYPE
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

      def MAXMSGTTL_TYPE
        @@MAXMSGTTL_TYPE
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

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def policy_name(arg=nil)
        set_or_return(:policy_name,arg,:kind_of => String)
      end

      def subscription(arg=nil)
        set_or_return(:subscription,arg,:kind_of => String)
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

      def max_msgs(arg=nil)
        set_or_return(:max_msgs,arg,:kind_of =>Integer )
      end

      def action_list(arg=nil)
        set_or_return(:action_list,arg,:kind_of =>String )
      end

      def max_msgsbehave (arg=nil)
        set_or_return(:max_msgsbehave,arg,:kind_of => String)
      end

    end
  end
end
        
