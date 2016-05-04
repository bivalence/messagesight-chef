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
    class IMAServerSecProfile < Chef::Resource

      provides :imaserver_secProfile

      @@NAME_TYPE="SecurityProfile"
      @@DESCRIPTION_TYPE="Description"

      @@TLSENABLE_TYPE="TLSEnabled"
      @@LTPAPROFILE_TYPE="LTPAProfile"
      @@OAUTHPROFILE_TYPE="OAuthProfile"
      @@MINPROTOCOL_TYPE="MinimumProtocolMethod"
      @@CERTPROFILE_TYPE="CertificateProfile"
      @@USECLIENT_CERT_TYPE="UseClientCertificate"
      @@USEPASSWD_AUTH_TYPE="UsePasswordAuthentication"
      @@CIPHERS_TYPE="Ciphers"
      @@USECLIENT_CIPHER_TYPE="UseClientCipher"

      def initialize(name, run_context = nil)
        Chef::Log.debug("sec_profile: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("sec_profile: initialize")
        @resource_name = :imaserver_secProfile
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerSecProfile

        #default action
        @action = :create

        #define secprofile attrs
        @description=""
        @profile_name = name
        @tls_enable=false
        @ltpa_profile=nil
        @oauth_profile=nil
        @min_protocol=nil
        @cert_profile=nil
        @useclient_cert=false
        @usepasswd_auth=false
        @ciphers=nil
        @useclient_cipher=false
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def TLSENABLE_TYPE      
        @@TLSENABLE_TYPE
      end
      
      def LTPAPROFILE_TYPE      
        @@LTPAPROFILE_TYPE
      end
      
      def OAUTHPROFILE_TYPE      
        @@OAUTHPROFILE_TYPE
      end
      
      def MINPROTOCOL_TYPE      
        @@MINPROTOCOL_TYPE
      end
      
      def CERTPROFILE_TYPE      
        @@CERTPROFILE_TYPE
      end
      
      def USECLIENT_CERT_TYPE      
        @@USECLIENT_CERT_TYPE
      end

      def USEPASSWD_AUTH_TYPE      
        @@USEPASSWD_AUTH_TYPE
      end
      
      def CIPHERS_TYPE      
        @@CIPHERS_TYPE
      end
      
      def USECLIENT_CIPHER_TYPE      
        @@USECLIENT_CIPHER_TYPE
      end


      def description(arg=nil)
        set_or_return(:description,arg,:kind_of => String)
      end

      def profile_name(arg=nil)
        set_or_return(:profile_name,arg,:kind_of => String)
      end

      def tls_enable(arg=nil)
        set_or_return(:tls_enable,arg,:kind_of => [TrueClass,FalseClass])
      end

      def ltpa_profile(arg=nil)
        set_or_return(:ltpa_profile,arg,:kind_of => String)
      end

      def oauth_profile(arg=nil)
        set_or_return(:oauth_profile,arg,:kind_of => String)
      end

      def min_protocol(arg=nil)
        set_or_return(:min_protocol,arg,:kind_of => String)
      end

      def cert_profile(arg=nil)
        set_or_return(:cert_profile,arg,:kind_of => String)
      end

      def useclient_cert(arg=nil)
        set_or_return(:useclient_cert,arg,:kind_of => [TrueClass,FalseClass])
      end

      def usepasswd_auth(arg=nil)
        set_or_return(:usepasswd_auth,arg,:kind_of => [TrueClass,FalseClass])
      end

      def ciphers(arg=nil)
        set_or_return(:ciphers,arg,:kind_of => String)
      end

      def useclient_cipher(arg=nil)
        set_or_return(:useclient_cipher,arg,:kind_of => [TrueClass,FalseClass])
      end

    end
  end
end
        
