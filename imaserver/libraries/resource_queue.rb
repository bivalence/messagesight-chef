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
    class IMAServerQueue < Chef::Resource

      provides :imaserver_queue

      @@NAME_TYPE="Queue"
      @@DESCRIPTION_TYPE="Description"
      @@ALLOWSEND_TYPE="AllowSend"
      @@CONCURRENTCON_TYPE="ConcurrentConsumers"
      @@MAXMSGS_TYPE="MaxMessages"

      def initialize(name, run_context = nil)
        Chef::Log.debug("queue: right before super name:#{name}")
        super
        Chef::Log.debug("queue: initialize")
        @resource_name = :imaserver_queue
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerQueue

        #default action
        @action = :create

        #define queue attrs
        @description=nil
        @queue_name = name
        @allow_send = false
        @concurr_consumers = false
        @max_msgs = 0
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def ALLOWSEND_TYPE
        @@ALLOWSEND_TYPE
      end

      def CONCURRENTCON_TYPE
        @@CONCURRENTCON_TYPE
      end

      def MAXMSGS_TYPE
        @@MAXMSGS_TYPE
      end

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def queue_name(arg=nil)
        set_or_return(:queue_name,arg,:kind_of => String,:required => true)
      end

      def allow_send(arg=nil)
        set_or_return(:allow_send,arg,:kind_of => [FalseClass,TrueClass],:required => true)
      end

      def concurr_consumers(arg=nil)
        set_or_return(:concurr_consumers,arg,:kind_of =>[FalseClass,TrueClass],:required => true)
      end

      def max_msgs(arg=nil)
        set_or_return(:max_msgs,arg,:kind_of => Integer,:required => true)
      end

    end
  end
end
        
