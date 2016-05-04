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
    class IMAServerConfigurationPolicy < Chef::Resource

      provides :imaserver_configPolicy

      @@NAME_TYPE="ConfigurationPolicy"
      @@DESCRIPTION_TYPE="Description"
      @@COMMONNAMES_TYPE="CommonNames"
      @@GROUPID_TYPE="GroupID"
      @@CLIENTADDRESS_TYPE="ClientAddress"
      @@USERID_TYPE="UserID"
      @@ACTIONLIST_TYPE="ActionList"

      def initialize(name, run_context = nil)
        Chef::Log.debug("IMAServerConfigurationPolicy: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("IMAServerConfigurationPolicy: initialize")
        @resource_name = :imaserver_configPolicy
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerConfigurationPolicy

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @config_name = name
        @cert_common_names=nil
        @group_id=nil
        @client_addr=nil
        @user_id=nil
        @action_list=nil
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

      def GROUPID_TYPE
        @@GROUPID_TYPE
      end

      def CLIENTADDRESS_TYPE
        @@CLIENTADDRESS_TYPE
      end

      def USERID_TYPE
        @@USERID_TYPE
      end

      def ACTIONLIST_TYPE
        @@ACTIONLIST_TYPE
      end

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def config_name(arg=nil)
        set_or_return(:config_name,arg,:kind_of => String)
      end

      def cert_common_names(arg=nil)
        set_or_return(:common_names,arg,:kind_of =>String )
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

      def action_list(arg=nil)
        set_or_return(:action_list,arg,:kind_of =>String )
      end

    end
  end
end
        
