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
    class IMAServerTrustedCert < Chef::Resource

      provides :imaserver_trustedCert

      @@NAME_TYPE="TrustedCertificate"
      @@TRUSTEDCERTIFICATE_TYPE="TrustedCertificate"
      @@SECURITYPROFILE_TYPE="SecurityProfileName"
      
      def initialize(name, run_context = nil)
        Chef::Log.debug("trustedcert: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("trustedcert: initialize")
        @resource_name = :imaserver_trustedCert
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerTrustedCert

        #default action
        @action = :create

        #define cert attrs
        @trustedcert_name = name
        @trustedcert_file = nil
        @secprofile=nil
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def TRUSTEDCERTIFICATE_TYPE
        @@TRUSTEDCERTIFICATE_TYPE
      end

      def SECURITYPROFILE_TYPE
        @@SECURITYPROFILE_TYPE
      end

      def trustedcert_name(arg=nil)
        set_or_return(:trustedcert_name,arg,:kind_of => String, :required => true)
      end

      def trustedcert_file(arg=nil)
        set_or_return(:trustedcert_file,arg,{:kind_of => String, :required =>true})
      end

      def sec_profile(arg=nil)
        set_or_return(:sec_profile,arg,{:kind_of => String, :required =>true})
      end

    end
  end
end
        
