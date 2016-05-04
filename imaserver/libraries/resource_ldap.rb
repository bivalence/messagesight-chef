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
    class IMAServerLdap < Chef::Resource

      provides :imaserver_ldap

      @@NAME_TYPE="LDAP"
      @@ENABLE_TYPE="Enabled"
      @@NETSTEDGROUPSEARCH_TYPE="NestedGroupSearch"
      @@URL_TYPE="URL"
      @@CERT_TYPE="Certificate"
      @@IGNORECASE_TYPE="IgnoreCase"
      @@BASEDN_TYPE="BaseDN"
      @@BINDDN_TYPE="BindDN"
      @@BINDPWD_TYPE="BindPassword"
      @@USERSUFFIX_TYPE="UserSuffix"
      @@GROUPSUFFIX_TYPE="GroupSuffix"
      @@GROUPCACHETIMEOUT_TYPE="GroupCacheTimeout"
      @@USERIDMAP_TYPE="UserIdMap"
      @@GROUPIDMAP_TYPE="GroupIdMap"
      @@TIMEOUT_TYPE="Timeout"
      @@ENABLECACHE_TYPE="EnableCache"
      @@CACHETIMEOUT_TYPE="CacheTimeout"
      @@MAXCONNS_TYPE="MaxConnections"
      @@GROUPMEMBERID_TYPE="GroupMemberIdMap"
      @@VERIFY_TYPE="Verify"

      def initialize(name, run_context = nil)
        Chef::Log.debug("ldap: right before super name:#{name}")
        super
        #Chef::Resource attrs
        Chef::Log.debug("ldap: initialize")
        @resource_name = :imaserver_ldap
        @allowed_actions = [:create,:post]
        @provider = Chef::Provider::IMAServerLdap


        @url_name = name
        @enable=false
        @nested_grp_search=false
        @cert=nil
        @ignore_case=false
        @base_dn=nil
        @bind_dn=nil
        @bind_pwd=nil
        @user_suffix=nil
        @grp_suffix=nil
        @grp_cache_timeout=nil
        @userid_map=nil
        @grpid_map=nil
        @timeout=nil
        @enable_cache=false
        @cache_timeout=nil

        @max_conns=nil
        @grpmemid_map=nil
        @verify=false
      end

      def NAME_TYPE
        @@NAME_TYPE
      end

      def ENABLE_TYPE
        @@ENABLE_TYPE
      end

      def NETSTEDGROUPSEARCH_TYPE
        @@NETSTEDGROUPSEARCH_TYPE
      end

      def URL_TYPE
        @@URL_TYPE
      end

      def CERT_TYPE
        @@CERT_TYPE
      end

      def IGNORECASE_TYPE
        @@IGNORECASE_TYPE
      end

      def BASEDN_TYPE
        @@BASEDN_TYPE
      end

      def BINDDN_TYPE
        @@BINDDN_TYPE
      end

      def BINDPWD_TYPE
        @@BINDPWD_TYPE
      end

      def USERSUFFIX_TYPE
        @@USERSUFFIX_TYPE
      end

      def GROUPSUFFIX_TYPE
        @@GROUPSUFFIX_TYPE
      end

      def GROUPCACHETIMEOUT_TYPE
        @@GROUPCACHETIMEOUT_TYPE
      end

      def USERIDMAP_TYPE
        @@USERIDMAP_TYPE
      end

      def GROUPIDMAP_TYPE
        @@GROUPIDMAP_TYPE
      end

      def TIMEOUT_TYPE
        @@TIMEOUT_TYPE
      end

      def ENABLECACHE_TYPE
        @@ENABLECACHE_TYPE
      end

      def CACHETIMEOUT_TYPE
        @@CACHETIMEOUT_TYPE
      end

      def DESCRIPTION_TYPE
        @@DESCRIPTION_TYPE
      end

      def MAXCONNS_TYPE
        @@MAXCONNS_TYPE
      end

      def GROUPMEMBERID_TYPE
        @@GROUPMEMBERID_TYPE
      end

      def VERIFY_TYPE
        @@VERIFY_TYPE
      end


      def enable(arg=nil)
        set_or_return(:enabled,arg,:kind_of => [TrueClass,FalseClass])
      end


      def url_name(arg=nil)
        set_or_return(:url_name,arg,:kind_of => String,:required => true)
      end

      def nested_grp_search(arg=nil)
        set_or_return(:nested_grp_search,arg,:kind_of => [TrueClass,FalseClass])
      end

      def cert(arg=nil)
        set_or_return(:cert,arg,:kind_of => String)
      end

      def ignore_case(arg=nil)
        set_or_return(:ignore_case,arg,:kind_of => [TrueClass,FalseClass])
      end

      def base_dn(arg=nil)
        set_or_return(:base_dn,arg,:kind_of => String)
      end

      def bind_dn(arg=nil)
        set_or_return(:bind_dn,arg,:kind_of => String)
      end

      def bind_pwd(arg=nil)
        set_or_return(:bind_pwd,arg,:kind_of => String)
      end
      
      def user_suffix(arg=nil)
        set_or_return(:user_suffix,arg,:kind_of => String)
      end

      def grp_suffix(arg=nil)
        set_or_return(:grp_suffix,arg,:kind_of => String)
      end

      def grp_cache_timeout(arg=nil)
        set_or_return(:grp_cache_timeout,arg,:kind_of => Integer)
      end

      def userid_map(arg=nil)
        set_or_return(:userid_map,arg,:kind_of => String)
      end

      def grpid_map(arg=nil)
        set_or_return(:grpid_map,arg,:kind_of => String)
      end

      def timeout(arg=nil)
        set_or_return(:timeout,arg,:kind_of => Integer)
      end

      def enable_cache(arg=nil)
        set_or_return(:enable_cache,arg,:kind_of => [TrueClass,FalseClass])
      end

      def cache_timeout(arg=nil)
        set_or_return(:cache_timeout,arg,:kind_of => Integer)
      end

      def max_conns(arg=nil)
        set_or_return(:max_conns,arg,:kind_of => Integer)
      end

      def grpmemid_map(arg=nil)
        set_or_return(:grpmemid_map,arg,:kind_of => String)
      end
      
      def verify(arg=false)
        set_or_return(:verify,arg,:kind_of => [TrueClass,FalseClass])
      end

      
    end
  end
end
        
