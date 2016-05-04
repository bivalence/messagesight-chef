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
    class IMAServerCertProfile < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerCertProfile provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerCertProfile.new(new_resource.profile_name)

        @current_resource.key_file(new_resource.key_file)
        @current_resource.cert_file(new_resource.cert_file)
        @current_resource.overwrite(new_resource.overwrite)
        @current_resource.expired_date(new_resource.expired_date)
        Chef::Log.debug("IMAServerCertProfile provider: load_current_resource: exit")
        @current_resource
      end

      def action_create
        Chef::Log.debug("certprofile provider: action_create")
        
        #we onlyuse the filename string for both cert and key. The fullpath
        #will be used by admin provider to 'put' a file onto server
        #check existence of cert files. TODO: maybe do existence during resource?
        if Chef::File.exist?(new_resource.key_file)
          key_name = Chef::File.basename(new_resource.key_file)
          Chef::Log.debug("certprofile provider: Using keyfile #{new_resource.key_file}")
        else
          Chef::Log.error("certprofile provider: keyfile #{new_resource.key_file} does not exist!")
        end

        if Chef::File.exist?(new_resource.cert_file)
          cert_name = Chef::File.basename(new_resource.cert_file)
          Chef::Log.debug("certprofile provider: Using certfile #{new_resource.cert_file}")
        else
          Chef::Log.error("certprofile provider: certfile #{new_resource.cert_file} does not exist!")
        end

        #Create json object

        json_obj = {new_resource.NAME_TYPE => {new_resource.profile_name => {
              new_resource.CERTIFICATE_TYPE => cert_name, 
              new_resource.KEY_TYPE=>key_name, 
              new_resource.OVERWRITE_TYPE => new_resource.overwrite,
              new_resource.EXPIRATIONDATE_TYPE => new_resource.expired_date,
            }}}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("certprofile provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("certprofile provider: json_payload: #{json_payload}")


        #instead of creating json obj for files, just insert files into array
        @@cert_files.insert(0,new_resource.cert_file)
        @@cert_files.insert(0,new_resource.key_file)
        @@cert_profiles.insert(0,json_obj)

        new_resource.updated_by_last_action(true)

      end

      def action_post
        #setup certificate profiles first
        #before setting up profiles, need to upload cert files using put
        @@cert_files.each do |afile|
          Chef::Log.debug("IMAServerCertProfile action post: cert file found: #{afile}")

          IMAServer::Helpers::File.put(afile)
        end

        #if no errors reset cert_files to empty array. 
        #Otherwise admin provider will post same objects
        #again on subsquent post
        @@cert_files=[]

        
        @@cert_profiles.each do |aprofile|
          Chef::Log.debug("IMAServerCertProfile action post: cert profile found: #{aprofile}")

          IMAServer::Helpers::Config.post(aprofile)
        end

        #if no errors reset cert_profiles to empty array. 
        @@cert_profiles=[]
      end

    end
  end
end
