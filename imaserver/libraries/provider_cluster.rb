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
   class IMAServerAdmin
    class IMAServerCluster < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerCluster provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerAdmin::IMAServerCluster.new(new_resource.cluster_name)
        @current_resource.enable_membership(new_resource.enable_membership)
        @current_resource.cluster_name(new_resource.cluster_name)
        @current_resource.multicast_discovery(new_resource.multicast_discovery)
        @current_resource.multicast_ttl(new_resource.multicast_ttl)
        @current_resource.discovery_time(new_resource.discovery_time)
        @current_resource.discovery_port(new_resource.discovery_port)
        @current_resource.discovery_list(new_resource.discovery_list)
        @current_resource.msg_addr(new_resource.msg_addr)
        @current_resource.msg_port(new_resource.msg_port)
        @current_resource.control_addr(new_resource.control_addr)
        @current_resource.control_port(new_resource.control_port)
        @current_resource.msg_tls(new_resource.msg_tls)
        Chef::Log.debug("IMAServerCluster provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("cluster provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {
            new_resource.CLUSTERNAME_TYPE => new_resource.cluster_name,
            new_resource.ENABLEMEMBERSHIP_TYPE => new_resource.enable_membership,
            new_resource.USEMULTICASTDISCOVERY_TYPE => new_resource.multicast_discovery,
            new_resource.MULTICASTDISCOVERYTTL_TYPE => new_resource.multicast_ttl,
            new_resource.CONTROLADDRESS_TYPE => new_resource.control_addr,
            new_resource.CONTROLPORT_TYPE => new_resource.control_port,
            new_resource.MESSAGINGADDRESS_TYPE => new_resource.msg_addr,
            new_resource.MESSAGINGPORT_TYPE => new_resource.msg_port,
            new_resource.MESSAGINGUSETLS_TYPE => new_resource.msg_tls,
            new_resource.DISCOVERYLIST_TYPE => (new_resource.discovery_list.join(',') if new_resource.discovery_list),
            new_resource.DISCOVERYTIME_TYPE => new_resource.discovery_time,
            new_resource.DISCOVERYPORT_TYPE => new_resource.discovery_port

}}

        Chef::Log.debug("cluster provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("cluster provider: json_payload: #{json_payload}")

        @@cluster=json_obj
        new_resource.updated_by_last_action(true)
      end

      def action_post
        #setup cluster
        if @@cluster
          Chef::Log.debug("IMAServerCluster action post: cluster found: #{@@cluster}")

          IMAServer::Helpers::Config.post(@@cluster)
        end
        #if no errors reset cluster to nil. 
        @@cluster=nil

      end
    end
  end
end
end
