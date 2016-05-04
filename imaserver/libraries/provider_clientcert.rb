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



class Chef
  class Provider
    class IMAServerClientCert < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerClientCert provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerClientCert.new(new_resource.clientcert_name)

        @current_resource.clientcert_file(new_resource.clientcert_file)
        @current_resource.clientcert_name(new_resource.clientcert_name)
        Chef::Log.debug("IMAServerClientCert provider: load_current_resource: exit")
        @current_resource
      end

      def action_create
        Chef::Log.debug("clientcert provider: action_create")
        
        #we onlyuse the filename string for both cert and key. The fullpath
        #will be used by admin provider to 'put' a file onto server
        #check existence of cert files. TODO: maybe do existence during resource?
        if Chef::File.exist?(new_resource.clientcert_file)
          clientcert_name = Chef::File.basename(new_resource.clientcert_file)
          Chef::Log.debug("clientcert provider: Using keyfile #{new_resource.clientcert_file}")
        else
          Chef::Log.error("clientcert provider: keyfile #{new_resource.clientcert_file} does not exist!")
        end

        #Create json object
        #client cert is a json array. therefore add brackets
        json_obj = {new_resource.CLIENTCERTIFICATE_TYPE => [
              new_resource.NAME_TYPE => clientcert_name, 
              new_resource.SECURITYPROFILE_TYPE => new_resource.sec_profile,
            ]}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("clientcert provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("clientcert provider: json_payload: #{json_payload}")


        #instead of creating json obj for files, just insert files into array
        @@clientcert_files.insert(0,new_resource.clientcert_file)
        @@clientcerts.insert(0,json_obj)

        new_resource.updated_by_last_action(true)

      end

      def action_post
        #setup certificate profiles first
        #before setting up profiles, need to upload cert files using put
        @@clientcert_files.each do |afile|
          Chef::Log.debug("IMAServerClientCert action post: cert file found: #{afile}")

          IMAServer::Helpers::File.put(afile)
        end

        #if no errors reset cert_files to empty array. 
        #Otherwise admin provider will post same objects
        #again on subsquent post
        @@clientcert_files=[]

        
        @@clientcerts.each do |acert|
          Chef::Log.debug("IMAServerClientCert action post: cert profile found: #{acert}")

          IMAServer::Helpers::Config.post(acert)
        end

        #if no errors reset cert_profiles to empty array. 
        @@clientcerts=[]
      end

    end
  end
end
