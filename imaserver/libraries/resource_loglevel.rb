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
    class IMAServerLogLevel < Chef::Resource

      provides :imaserver_loglevel

      @@NAME_TYPE="LogLevel"

      def initialize(name, run_context = nil)
        Chef::Log.debug("loglevel: right before super name:#{name}")
        super
        #Chef::Resource attrs
        Chef::Log.debug("loglevel: initialize")
        @resource_name = :imaserver_loglevel
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerLogLevel

        @level_name = name
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def level_name(arg=nil)
        set_or_return(:level_name,arg,:kind_of => String,:required => true)
      end

    end
  end
end
        
