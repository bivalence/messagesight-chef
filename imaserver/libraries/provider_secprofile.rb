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


#include IMAServerAdmin::Helpers

class Chef
  class Provider
    class IMAServerSecProfile < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerSecProfile provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerSecProfile.new(new_resource.profile_name)
        @current_resource.description(new_resource.description)
        @current_resource.profile_name(new_resource.profile_name)
        @current_resource.tls_enable(new_resource.tls_enable)
        @current_resource.ltpa_profile(new_resource.ltpa_profile)
        @current_resource.oauth_profile(new_resource.oauth_profile)
        @current_resource.min_protocol(new_resource.min_protocol)
        @current_resource.cert_profile(new_resource.cert_profile)
        @current_resource.useclient_cert(new_resource.useclient_cert)
        @current_resource.usepasswd_auth(new_resource.usepasswd_auth)
        @current_resource.ciphers(new_resource.ciphers)
        @current_resource.useclient_cipher(new_resource.useclient_cipher)

        Chef::Log.debug("IMAServerSecProfile provider: load_current_resource: exit")
        @current_resource

      end

      def action_create
        Chef::Log.debug("IMAServerSecProfile provider: action_create")
       
#        json_obj = IMAServerAdmin::Hash.new

       json_obj = Hash.[](new_resource.NAME_TYPE => {new_resource.profile_name =>{
                              new_resource.TLSENABLE_TYPE => new_resource.tls_enable,  
                              new_resource.LTPAPROFILE_TYPE => new_resource.ltpa_profile,
                              new_resource.OAUTHPROFILE_TYPE => new_resource.oauth_profile ,
                              new_resource.MINPROTOCOL_TYPE => new_resource.min_protocol,
                              new_resource.CERTPROFILE_TYPE => new_resource.cert_profile,
                              new_resource.USECLIENT_CERT_TYPE => new_resource.useclient_cert,
                              new_resource.USEPASSWD_AUTH_TYPE => new_resource.usepasswd_auth,
                              new_resource.CIPHERS_TYPE => new_resource.ciphers,
                              new_resource.USECLIENT_CIPHER_TYPE => new_resource.useclient_cipher,

                            }})

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("IMAServerSecProfile provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("IMAServerSecProfile provider: json_payload: #{json_payload}")


        @@sec_profiles.insert(0,json_obj)
        new_resource.updated_by_last_action(true)

      end

      def action_post
        @@sec_profiles.each do |aprofile|
          Chef::Log.debug("IMAServerSecProfile action post: sec profile found: #{aprofile}")

          IMAServer::Helpers::Config.post(aprofile)
        end

        #if no errors reset sec_policies to empty array. 
        @@sec_profiles=[]

      end
    end
  end
end
