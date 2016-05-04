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
    class IMAServerEndpoint < Chef::Resource

      provides :imaserver_endpoint

      @@NAME_TYPE="Endpoint"
      @@DESCRIPTION_TYPE="Description"
      @@SECPROFILE_TYPE="SecurityProfile"
      @@MSGHUB_TYPE="MessageHub"
      @@MAXSENDSZ_TYPE="MaxSendSize"
      @@MAXMSGSZ_TYPE="MaxMessageSize"
      @@ENABLE_TYPE="Enabled"
      @@BATCHMSGS_TYPE="BatchMessages"
      @@PORT_TYPE="Port"
      @@PROTOCOL_TYPE="Protocol"
      @@INTERFACE_TYPE="Interface"
      @@INTERFACENAME_TYPE="InterfaceName"
      @@CONNPOLICIES_TYPE="ConnectionPolicies"
      @@TOPICPOLICIES_TYPE="TopicPolicies"
      @@QUEUEPOLICIES_TYPE="QueuePolicies"
      @@SUBSCRIPTIONPOLICIES_TYPE="SubscriptionPolicies"

      def initialize(name, run_context = nil)
        Chef::Log.debug("IMAServerEndpoint: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("IMAServerEndpoint: initialize")
        @resource_name = :imaserver_endpoint
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerEndpoint

        #default action
        @action = :create

        #define hub attrs
        @description=nil
        @endpoint_name = name
        @sec_profile=nil
        @msg_hub=nil
        @max_sendsz=16384
        @max_msgsz="1024KB"
        @enable=true
        @batch_msgs=true
        @port=nil
        @protocol="JMS,MQTT"
        @interface=nil
        @interface_name=nil
        @conn_policies=nil
        @topic_policies=nil
        @queue_policies=nil
        @subscription_policies=nil
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def SECPROFILE_TYPE 
        @@SECPROFILE_TYPE
      end

      def MSGHUB_TYPE
        @@MSGHUB_TYPE
      end

      def MAXSENDSZ_TYPE 
        @@MAXSENDSZ_TYPE
      end

      def MAXMSGSZ_TYPE 
        @@MAXMSGSZ_TYPE
      end

      def ENABLE_TYPE 
        @@ENABLE_TYPE
      end

      def BATCHMSGS_TYPE 
        @@BATCHMSGS_TYPE
      end

      def PORT_TYPE 
        @@PORT_TYPE
      end

      def PROTOCOL_TYPE 
        @@PROTOCOL_TYPE
      end

      def INTERFACE_TYPE 
        @@INTERFACE_TYPE
      end

      def INTERFACENAME_TYPE 
        @@INTERFACENAME_TYPE
      end

      def CONNPOLICIES_TYPE 
        @@CONNPOLICIES_TYPE
      end

      def TOPICPOLICIES_TYPE
        @@TOPICPOLICIES_TYPE
      end
      
      def QUEUEPOLICIES_TYPE
        @@QUEUEPOLICIES_TYPE
      end
      
      def SUBSCRIPTIONPOLICIES_TYPE
        @@SUBSCRIPTIONPOLICIES_TYPE
      end


      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def endpoint_name(arg=nil)
        set_or_return(:endpoint_name,arg,:kind_of => String)
      end

      def sec_profile(arg=nil)
        set_or_return(:sec_profile,arg,:kind_of => String)
      end

      def msg_hub(arg=nil)
        set_or_return(:msg_hub,arg,:kind_of => String)
      end

      def max_sendsz(arg=nil)
        set_or_return(:max_sendsz,arg,:kind_of => Integer)
      end

      def max_msgsz(arg=nil)
        set_or_return(:max_msgsz,arg,:kind_of => String)
      end

      def enable(arg=nil)
        set_or_return(:enable,arg,:kind_of => [TrueClass,FalseClass])
      end

      def batch_msgs(arg=nil)
        set_or_return(:batch_msgs,arg,:kind_of => [TrueClass,FalseClass])
      end

      def port(arg=nil)
        set_or_return(:port,arg,:kind_of => Integer,:required => true)
      end

      def protocol(arg=nil)
        set_or_return(:protocol,arg,:kind_of => String)
      end

      def interface(arg=nil)
        set_or_return(:interface,arg,:kind_of => String)
      end

      def interface_name(arg=nil)
        set_or_return(:interface_name,arg,:kind_of => String)
      end

      def conn_policies(arg=nil)
        set_or_return(:conn_policies,arg,:kind_of => Array)
      end

      def topic_policies(arg=nil)
        set_or_return(:topic_policies,arg,:kind_of =>Array)
      end

      def queue_policies(arg=nil)
        set_or_return(:queue_policies,arg,:kind_of =>Array)
      end

      def subscription_policies(arg=nil)
        set_or_return(:subscription_polcies,arg,:kind_of =>Array)
      end

    end
  end
end
        
