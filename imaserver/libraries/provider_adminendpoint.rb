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

# Provider class for IMAServerAdmin resource
class Chef
  class Provider

    class IMAServerAdminEndpoint < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerAdminEndpoint provider: load_current_resource: enter")
        @current_resource ||= Chef::Resource::IMAServerAdminEndpoint.new(new_resource.host_name)

        @current_resource.host_name(new_resource.host_name)

        #setup admin config
        @current_resource.interface(new_resource.host)
        @current_resource.port(new_resource.port)

        Chef::Log.debug("IMAServerAdminEndpoint provider: load_current_resource: exit")
        @current_resource
      end

      def action_create
        Chef::Log.debug("IMAServerAdminEndpint provider: action_create")

        json_obj = {new_resource.NAME_TYPE => {
            new_resource.SECURITYPROFILE_TYPE=>new_resource.sec_profile,
            new_resource.PORT_TYPE=>new_resource.port,
            new_resource.INTERFACE_TYPE=>new_resource.interface,
            new_resource.CONFIGURATIONPOLCIES_TYPE => (new_resource.config_policy.join(',') if new_resource.config_policy)
}}
        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("admin_endpoint provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("admin_endpoint: json_payload: #{json_payload}")

        @@admin_endpoint=json_obj
        new_resource.updated_by_last_action(true)
        
     end

      def action_post
        Chef::Log.debug("IMAServerAdminEndpoint provider: action_post enter")

        Chef::Log.debug("IMAServerAdminEndpoint posting new endpoint setting")
        IMAServer::Helpers::Config.post(@@admin_endpoint)

        #after successful change of endpoint, need to change the local endpoint host and port
        Chef::Log.debug("IMAServerAdminEndpoint setting IMAServer Helper accessor attributes ipaddress: #{new_resource.interface} port: #{new_resource.port}")

        IMAServer::host=new_resource.interface
        IMAServer::port=new_resource.port

        #if no errors reset admin_endpoint to nil. Otherwise admin provider will post
        #again since its actually IMAServerAdmin class var
        @@admin_endpoint=nil
        Chef::Log.debug("IMAServerAdminEndpoint provider: action_post exit")
      end

    end
  end
end
