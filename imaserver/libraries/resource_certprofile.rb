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
    class IMAServerCertProfile < Chef::Resource

      provides :imaserver_certProfile

      @@NAME_TYPE="CertificateProfile"
      @@CERTIFICATE_TYPE="Certificate"
      @@KEY_TYPE="Key"
      @@OVERWRITE_TYPE="Overwrite"
      @@EXPIRATIONDATE_TYPE="ExpirationDate"
      
      #setup internal json types not related to imaserver reset api
      @@files_type="files"
      @@keyfile_type="keyfile"
      @@certfile_type="certfile"

      def initialize(name, run_context = nil)
        Chef::Log.debug("certprofile: right before super name:#{name}")
        super

        #Chef::Resource attrs
        Chef::Log.debug("certprofile: initialize")
        @resource_name = :imaserver_certProfile
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerAdmin::IMAServerCertProfile

        #default action
        @action = :create

        #define cert attrs
        @profile_name = name
        @cert_file = nil
        @key_file = nil
        @overwrite=false
        @expired_date = nil
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def CERTIFICATE_TYPE
        @@CERTIFICATE_TYPE
      end

      def KEY_TYPE
        @@KEY_TYPE
      end

      def OVERWRITE_TYPE
        @@OVERWRITE_TYPE
      end

      def EXPIRATIONDATE_TYPE
        @@EXPIRATIONDATE_TYPE
      end

      def profile_name(arg=nil)
        set_or_return(:profile_name,arg,:kind_of => String, :required => true)
      end

      def cert_file(arg=nil)
        set_or_return(:cert_file,arg,{:kind_of => String, :required =>true})
      end

      def key_file(arg=nil)
        set_or_return(:key_file,arg,:kind_of => String,:required => true)
      end

      def overwrite(arg=nil)
        set_or_return(:overwrite,arg,:kind_of => [TrueClass,FalseClass])
      end
      
      def expired_date(arg=nil)
        set_or_return(:expired_date,arg,:kind_of => String)
      end
    end
  end
end
        
