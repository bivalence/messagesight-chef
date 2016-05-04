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
    class IMAServerHA < Chef::Resource

      provides :imaserver_ha

      @@NAME_TYPE="HighAvailability"
      @@GROUP_TYPE="Group"
      @@ENABLE_TYPE="EnableHA"
      @@PRIMARY_TYPE="PreferredPrimary"
      @@LOCALREPLICATION_TYPE="LocalReplicationNIC"
      @@LOCALDISCOVERY_TYPE="LocalDiscoveryNIC"
      @@REMOTEDISCOVERY_TYPE="RemoteDiscoveryNIC"


      def initialize(name, run_context=nil)
        Chef::Log.debug("ha: right before super name:#{name}")
        super
        #Chef::Resource attrs
        Chef::Log.debug("ha: initialize")
        @resource_name = :imaserver_ha
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerHA

        @action = :create

        @group_name=name
        @enable=false
        @primary=false
        @local_replication=nil
        @local_discovery=nil
        @remote_discovery=nil
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def GROUP_TYPE
        @@GROUP_TYPE
      end

      def ENABLE_TYPE
        @@ENABLE_TYPE
      end

      def PRIMARY_TYPE
        @@PRIMARY_TYPE
      end

      def LOCALREPLICATION_TYPE
        @@LOCALREPLICATION_TYPE
      end

      def LOCALDISCOVERY_TYPE
        @@LOCALDISCOVERY_TYPE
      end

      def REMOTEDISCOVERY_TYPE
        @@REMOTEDISCOVERY_TYPE
      end


      def group_name(arg=nil)
        set_or_return(:group_name,arg,:kind_of => String)
      end

      def enable(arg=nil)
        set_or_return(:enable,arg,:kind_of => [TrueClass,FalseClass])
      end

      def primary(arg=nil)
        set_or_return(:primary,arg,:kind_of => [TrueClass,FalseClass])
      end

      def local_replication(arg=nil)
        set_or_return(:local_replication,arg,:kind_of => String)
      end

      def local_discovery(arg=nil)
        set_or_return(:local_discovery,arg,:kind_of => String)
      end

      def remote_discovery(arg=nil)
        set_or_return(:remote_replication,arg,:kind_of => String)
      end

      def remote_replication(arg=nil)
        set_or_return(:remote_discovery,arg,:kind_of => String)
      end

    end
  end
end




