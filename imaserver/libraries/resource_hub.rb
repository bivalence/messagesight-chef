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
    class IMAServerHub < Chef::Resource

      provides :imaserver_hub

      @@NAME_TYPE="MessageHub"
      @@DESCRIPTION_TYPE="Description"

      def initialize(name, run_context = nil)
        Chef::Log.debug("hub: right before super name:#{name}")
        super
        #Chef::Resource attrs
        Chef::Log.debug("hub: initialize")
        @resource_name = :imaserver_hub
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerHub


        @description=nil
        @hub_name = name
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def hub_name(arg=nil)
        set_or_return(:hub_name,arg,:kind_of => String,:required => true)
      end

    end
  end
end
        
