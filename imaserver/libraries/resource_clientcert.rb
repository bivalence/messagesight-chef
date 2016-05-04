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
    class IMAServerClientCert < Chef::Resource

      provides :imaserver_clientCert

      @@CLIENTCERTIFICATE_TYPE="ClientCertificate"
      @@NAME_TYPE="CertificateName"
      @@SECURITYPROFILE_TYPE="SecurityProfileName"
      
      def initialize(name, run_context = nil)
        Chef::Log.debug("clientcert: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("clientcert: initialize")
        @resource_name = :imaserver_clientCert
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerClientCert

        #default action
        @action = :create

        #define cert attrs
        @clientcert_name = name
        @clientcert_file = nil
        @secprofile=nil
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def CLIENTCERTIFICATE_TYPE
        @@CLIENTCERTIFICATE_TYPE
      end

      def SECURITYPROFILE_TYPE
        @@SECURITYPROFILE_TYPE
      end

      def clientcert_name(arg=nil)
        set_or_return(:clientcert_name,arg,:kind_of => String, :required => true)
      end

      def clientcert_file(arg=nil)
        set_or_return(:clientcert_file,arg,{:kind_of => String, :required =>true})
      end

      def sec_profile(arg=nil)
        set_or_return(:sec_profile,arg,{:kind_of => String, :required =>true})
      end

    end
  end
end
        
