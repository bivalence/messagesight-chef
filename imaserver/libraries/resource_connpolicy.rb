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
    class IMAServerConnPolicy < Chef::Resource

      provides :imaserver_connPolicy

      @@NAME_TYPE="ConnectionPolicy"
      @@DESCRIPTION_TYPE="Description"
      @@ALLOWEDPERSISTMSG_TYPE="AllowPersistentMessages"
      @@COMMONNAMES_TYPE="CommonNames"
      @@CLIENTID_TYPE="ClientID"
      @@GROUPID_TYPE="GroupID"
      @@CLIENTADDRESS_TYPE="ClientAddress"
      @@DESCRIPTION_TYPE="Description"
      @@USERID_TYPE="UserID"
      @@PROTOCOL_TYPE="Protocol"
      @@ALLOWDURABLE_TYPE="AllowDurable"

      def initialize(name, run_context = nil)
        Chef::Log.debug("connpolicy: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("connpolicy: initialize")
        @resource_name = :imaserver_connPolicy
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerConnPolicy

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @policy_name = name
        @allow_persist_msg=true
        @cert_common_names=nil
        @client_id=nil
        @group_id=nil
        @client_addr=nil
        @user_id=nil
        @protocol=nil
        @allow_durable=true
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def ALLOWEDPERSISTMSG_TYPE
        @@ALLOWEDPERSISTMSG_TYPE
      end

      def COMMONNAMES_TYPE
        @@COMMONNAMES_TYPE
      end
      def PROTOCOL_TYPE
        @@PROTOCOL_TYPE
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

      def ALLOWDURABLE_TYPE
        @@ALLOWDURABLE_TYPE
      end

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def policy_name(arg=nil)
        set_or_return(:policy_name,arg,:kind_of => String)
      end

      def allow_persist_msg(arg=nil)
        set_or_return(:allow_persist_msg,arg,:kind_of => [TrueClass,FalseClass])
      end

      def cert_common_names(arg=nil)
        set_or_return(:common_names,arg,:kind_of => String)
      end

      def client_id(arg=nil)
        set_or_return(:client_id,arg,:kind_of => String)
      end
      def group_id(arg=nil)
        set_or_return(:group_id,arg,:kind_of =>String)
      end
      def client_addr(arg=nil)
        set_or_return(:client_addr,arg,:kind_of =>String)
      end
      def user_id(arg=nil)
        set_or_return(:userid,arg,:kind_of =>String)
      end
      def protocol(arg=nil)
        set_or_return(:protocol,arg,:kind_of =>String)
      end
      def allow_durable(arg=nil)
        set_or_return(:allowdurable,arg,:kind_of => [TrueClass,FalseClass])
      end


    end
  end
end
        
