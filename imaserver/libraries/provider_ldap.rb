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
    class IMAServerLdap < Chef::Provider::IMAServerAdmin
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        Chef::Log.debug("IMAServerLdap provider: load_current_resource: enter")

        # @TODO: current_resource should retrive current resource state. In this case
        # it should determine if this hub is already configured. But for now
        # set it to new_resource
        @current_resource ||= Chef::Resource::IMAServerLdap.new(new_resource.url_name)

        @current_resource.url_name(new_resource.url_name)

        Chef::Log.debug("IMAServerLdap provider: load_current_resource: exit")

        @current_resource.enable(new_resource.enable)
        @current_resource.nested_grp_search(new_resource.nested_grp_search)
        @current_resource.cert(new_resource.cert)
        @current_resource.ignore_case(new_resource.ignore_case)
        @current_resource.base_dn(new_resource.base_dn)
        @current_resource.bind_dn(new_resource.bind_dn)
        @current_resource.bind_pwd(new_resource.bind_pwd)
        @current_resource.user_suffix(new_resource.user_suffix)
        @current_resource.grp_suffix(new_resource.grp_suffix)
        @current_resource.grp_cache_timeout(new_resource.grp_cache_timeout)
        @current_resource.userid_map(new_resource.userid_map)
        @current_resource.grpid_map(new_resource.grpid_map)
        @current_resource.timeout(new_resource.timeout)
        @current_resource.enable_cache(new_resource.enable_cache)
        @current_resource.cache_timeout(new_resource.cache_timeout)

      end

      def action_create
        Chef::Log.debug("ldap provider: action_create")
        
        json_obj = {new_resource.NAME_TYPE => {
            new_resource.ENABLE_TYPE => new_resource.enable,
            new_resource.NETSTEDGROUPSEARCH_TYPE => new_resource.nested_grp_search,
            new_resource.URL_TYPE => new_resource.url_name,
            new_resource.CERT_TYPE => new_resource.cert,
            new_resource.IGNORECASE_TYPE => new_resource.ignore_case,
            new_resource.BINDPWD_TYPE => new_resource.bind_pwd,
            new_resource.BINDDN_TYPE => new_resource.bind_dn,
            new_resource.BASEDN_TYPE => new_resource.base_dn,
            new_resource.GROUPSUFFIX_TYPE => new_resource.grp_suffix,
            new_resource.GROUPCACHETIMEOUT_TYPE => new_resource.grp_cache_timeout,
            new_resource.USERIDMAP_TYPE => new_resource.userid_map,
            new_resource.GROUPIDMAP_TYPE => new_resource.grpid_map,
            new_resource.TIMEOUT_TYPE => new_resource.timeout,
            new_resource.ENABLECACHE_TYPE => new_resource.enable_cache,
            new_resource.CACHETIMEOUT_TYPE => new_resource.cache_timeout,
            new_resource.MAXCONNS_TYPE => new_resource.max_conns,
            new_resource.GROUPMEMBERID_TYPE => new_resource.grpmemid_map,
            new_resource.VERIFY_TYPE => new_resource.verify,


           }}

        #remove nil and empty hash's
        json_obj.compact

        Chef::Log.debug("ldap provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("ldap provider: json_payload: #{json_payload}")

        @@ldap=json_obj
        new_resource.updated_by_last_action(true)
      end

      def action_post
        Chef::Log.debug("ldap provider: action_post enter")

        IMAServer::Helpers::Config.post(@@ldap)
        #if no errors reset admin_endpoint to nil. Otherwise admin provider will post
        #again since its actually IMAServerAdmin class var
        @@ldap=nil

        Chef::Log.debug("ldap provider: action_post exit")

      end
    end
end
end
