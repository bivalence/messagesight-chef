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
    class IMAServerCluster < Chef::Resource

      provides :imaserver_cluster

      @@NAME_TYPE="ClusterMembership"
      @@ENABLEMEMBERSHIP_TYPE="EnableClusterMembership"
      @@CLUSTERNAME_TYPE="ClusterName"
      @@USEMULTICASTDISCOVERY_TYPE="UseMulticastDiscovery"
      @@MULTICASTDISCOVERYTTL_TYPE="MulticastDiscoveryTTL"
      @@DISCOVERYLIST_TYPE="DiscoveryServerList"
      @@CONTROLADDRESS_TYPE="ControlAddress"
      @@CONTROLPORT_TYPE="ControlPort"
      @@MESSAGINGADDRESS_TYPE="MessagingAddress"
      @@MESSAGINGPORT_TYPE="MessagingPort"
      @@MESSAGINGUSETLS_TYPE="MessagingUseTLS"
      @@DISCOVERYTIME_TYPE="DiscoveryTime"
      @@DISCOVERYPORT_TYPE="DiscoveryPort"

      def initialize(name, run_context = nil)
        Chef::Log.debug("cluster: right before super name:#{name}")
        super
        #Chef::Resource attrs
        Chef::Log.debug("cluster: initialize")
        @resource_name = :imaserver_cluster
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerCluster

        @action = :create

        #define cluster attrs
        @cluster_name = name
        @enable_membership=false
        @multicast_discovery=false
        @multicast_ttl=16
        @discovery_time=30
        @discovery_port=0
        @discovery_list=nil
        @msg_addr=""
        @msg_port=0
        @msg_tls=false
        @control_addr=""
        @control_port=0
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def ENABLEMEMBERSHIP_TYPE
        @@ENABLEMEMBERSHIP_TYPE
      end

      def CLUSTERNAME_TYPE
        @@CLUSTERNAME_TYPE
      end

      def USEMULTICASTDISCOVERY_TYPE
        @@USEMULTICASTDISCOVERY_TYPE
      end

      def MULTICASTDISCOVERYTTL_TYPE
        @@MULTICASTDISCOVERYTTL_TYPE
      end

      def CONTROLADDRESS_TYPE
        @@CONTROLADDRESS_TYPE
      end

      def CONTROLPORT_TYPE
        @@CONTROLPORT_TYPE
      end

      def MESSAGINGADDRESS_TYPE
        @@MESSAGINGADDRESS_TYPE
      end

      def MESSAGINGPORT_TYPE
        @@MESSAGINGPORT_TYPE
      end

      def DISCOVERYTIME_TYPE
        @@DISCOVERYTIME_TYPE
      end

      def DISCOVERYLIST_TYPE
        @@DISCOVERYLIST_TYPE
      end

      def MESSAGINGUSETLS_TYPE
        @@MESSAGINGUSETLS_TYPE
      end

      def DISCOVERYPORT_TYPE
        @@DISCOVERYPORT_TYPE
      end

      def enable_membership(arg=nil)
        set_or_return(:enable_membership,arg,:kind_of => [TrueClass,FalseClass])
      end

      def cluster_name (arg=nil)
        set_or_return(:cluster_name ,arg,:kind_of => String)
      end

      def multicast_discovery(arg=nil)
        set_or_return(:multicast_discovery,arg,:kind_of => [TrueClass,FalseClass])
      end

      def multicast_ttl(arg=nil)
        set_or_return(:multicast_ttl,arg,:kind_of => Integer)
      end

      def discovery_time(arg=nil)
        set_or_return(:discovery_time,arg,:kind_of => Integer)
      end

      def discovery_list(arg=nil)
        set_or_return(:discovery_list,arg,:kind_of => Array)
      end

      def discovery_port(arg=nil)
        set_or_return(:discovery_port,arg,:kind_of => Integer)
      end

      def msg_addr(arg=nil)
        set_or_return(:msg_addr,arg,:kind_of => String)
      end

      def msg_port(arg=nil)
        set_or_return(:msg_port,arg,:kind_of => Integer)
      end

      def control_addr(arg=nil)
        set_or_return(:control_addr,arg,:kind_of => String)
      end

      def control_port(arg=nil)
        set_or_return(:control_port,arg,:kind_of => Integer)
      end

      def msg_tls(arg=nil)
        set_or_return(:msg_tls,arg,:kind_of => [TrueClass,FalseClass])
      end

    end
  end
end
        
