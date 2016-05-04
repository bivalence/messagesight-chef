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
    class IMAServerAdmin < Chef::Resource

      provides :imaserver_admin
      allowed_actions :test,:post,:delete,:get,:restart
      default_action :test

      @@SERVICE_TYPE="Service"
      @@LICENSEDUSAGE_TYPE="LicensedUsage"
      @@ACCEPT_TYPE="Accept"


      def initialize(name, run_context = nil)
        super
        #define Chef::Resource attrs
        @resource_name = :imaserver_admin

        @provider = Chef::Provider::IMAServerAdmin


        #define IMAServerAdmin default attrs

        @host = name
        @port = 9089


        #placeholder for future security requirements
        @secure = true
        @username = 'admin'
        @password = 'admin'

        #server name used for 'Service' objects
        @server_name = 'imaserver'

        #accept license
        @licensed_usage=""
        @accept=false

      end

      def LICENSEDUSAGE_TYPE
        @@LICENSEDUSAGE_TYPE
      end

      def ACCEPT_TYPE
        @@ACCEPT_TYPE
      end

      def SERVICE_TYPE
        @@SERVICE_TYPE
      end

      def licensed_usage(arg=nil)
        Chef::Log.debug("admin license usage: port: #{arg}")
        set_or_return(:licensed_usage,arg,:kind_of => String)
      end

      def accept(arg=nil)
        Chef::Log.debug("admin accept: port: #{arg}")
        set_or_return(:accept,arg,:kind_of => [TrueClass,FalseClass])
      end


      #resource methods
      def port(arg=nil)
        Chef::Log.debug("admin resource: port: #{arg}")
        #arg is passed in base on value used in 'imaserver_admin' block
        set_or_return(:port ,arg,:kind_of =>Integer )
      end

      def host(arg=nil)
        Chef::Log.debug("admin resource: host")
        set_or_return(:host ,arg,:kind_of =>String )
      end

      def secure(arg=nil)
        Chef::Log.debug("admin resource: secure")
        set_or_return(:secure ,arg,:kind_of => [TrueClass,FalseClass] )
      end

      def username(arg=nil)
        Chef::Log.debug("admin resource: user")
        set_or_return(:user ,arg, :kind_of => String )
      end

      def password(arg=nil)
        Chef::Log.debug("admin resource: password")
        set_or_return(:password ,arg, :kind_of => String )
      end

      def server_name(arg=nil)
        Chef::Log.debug("admin server_name: password")
        set_or_return(:server_name ,arg, :kind_of => String )
      end

    end
  end
end
