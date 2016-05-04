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
    class IMAServerMsgPolicy < Chef::Resource

      provides :imaserver_msgPolicy

      @@NAME_TYPE="MessagingPolicy"
      @@DESCRIPTION_TYPE="Description"
      @@COMMONNAMES_TYPE="CommonNames"
      @@CLIENTID_TYPE="ClientID"
      @@GROUPID_TYPE="GroupID"
      @@CLIENTADDRESS_TYPE="ClientAddress"
      @@USERID_TYPE="UserID"
      @@MAXMSGTTL="MaxMessageTimeToLive"
      @@PROTOCOL_TYPE="Protocol"
      @@DESTINATION_TYPE="Destination"
      @@DESTINATIONTYPE_TYPE="DestinationType"
      @@ACTIONLIST_TYPE="ActionList"
      @@MAXMSGS_TYPE="MaxMessages"
      @@MAXMSGSBEHAVIOR_TYPE="MaxMessagesBehavior"
      @@DISCONNCLIENTNOTIFY_TYPE="DisconnectedClientNotification"
      @@PENDINGACTION_TYPE="PendingAction"

      def initialize(name, run_context = nil)
        Chef::Log.debug("msgPolicy: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("msgPolicy: initialize")
        @resource_name = :imaserver_msgPolicy
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerMsgPolicy

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @policy_name = name
        @cert_common_names=nil
        @client_id=nil
        @group_id=nil
        @client_addr=nil
        @user_id=nil
        @protocol=nil
        @max_msgttl=nil  #default to unlimited seconds
        @max_msgs=5000      #default to 5000 max msgs
        @destination="*"    #default to wildcard (ie '*')
        @destination_type=nil
        @action_list=nil
        @max_msgsbehave=false
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

      def DESTINATION_TYPE
        @@DESTINATION_TYPE
      end

      def DESTINATIONTYPE_TYPE
        @@DESTINATIONTYPE_TYPE
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

      def destination(arg=nil)
        set_or_return(:destination,arg,:kind_of =>String )
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

      def destination_type(arg=nil)
        set_or_return(:destingation_type,arg,:kind_of => String)
      end

    end
  end
end
        
