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
    class IMAServerAdminEndpoint < Chef::Resource

      provides :imaserver_adminEndpoint


      @@NAME_TYPE="AdminEndpoint"
      @@SECURITYPROFILE_TYPE="SecurityProfile"
      @@PORT_TYPE="Port"
      @@INTERFACE_TYPE="Interface"
      @@CONFIGURATIONPOLCIES_TYPE="ConfigurationPolicies"

      def initialize(name, run_context = nil)
        super
        #define Chef::Resource attrs
        @resource_name = :imaserver_adminEndpoint
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdminEndpoint

        #default action
        @action = :create

        #define IMAServerAdmin default atts

        #hardcode admin endpoint name to 'AdminEndpoint', which is required and
        #actually name of config object
        @host_name = name
        @interface = host_name
        @port = nil

        # initialize reset to nil
        @security_profile = nil
        @config_policy = nil

      end

      #setup class vars methods
      def NAME_TYPE
        @@NAME_TYPE
      end
      
      def SECURITYPROFILE_TYPE
        @@SECURITYPROFILE_TYPE
      end

      def PORT_TYPE
        @@PORT_TYPE
      end
      
      def INTERFACE_TYPE
        @@INTERFACE_TYPE
      end

      def CONFIGURATIONPOLCIES_TYPE
        @@CONFIGURATIONPOLCIES_TYPE
      end

      #resource methods
      def host_name(arg=nil)
        Chef::Log.debug("admin resource: host name")
        #arg is passed in base on value used in 'imaserver_admin' block
        set_or_return(:host_name ,arg,:kind_of =>String )
      end

      def port(arg=nil)
        Chef::Log.debug("admin resource: port")
        #arg is passed in base on value used in 'imaserver_admin' block
        set_or_return(:port ,arg,:kind_of =>Integer )
      end

      def interface(arg=nil)
        Chef::Log.debug("admin resource: interface")
        set_or_return(:interface ,arg,:kind_of =>String )
      end

      def sec_profile(arg=nil)
        Chef::Log.debug("admin resource: admin security_profile")
        set_or_return(:sec_profile ,arg,:kind_of =>String )
      end

      def config_policy(arg=nil)
        Chef::Log.info("admin resource: admin config_profile")
        set_or_return(:config_policy ,arg,:kind_of =>Array )
      end

    end
  end
end
