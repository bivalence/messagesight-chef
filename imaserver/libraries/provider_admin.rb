#$:.unshift *Dir[File.expand_path('/usr/local/share/gems/gems/**/lib', __FILE__)]
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


# add compact to Hash class
class Hash
  def compact
    Chef::Log.debug("In imaserver admin Hash compact: #{Hash}")
    delete_if {|k,v| v.is_a?(Hash) ? v.compact.empty? : v.nil? }
  end
end
      
#include helper
include IMAServer

class Chef
  class Provider

    class IMAServerAdmin < Chef::Provider

      use_inline_resources if defined?(use_inline_resources)

      #use class variables to store various config objects
      @@cert_profiles=[]
      @@cert_files=[]
      @@trustedcerts=[]
      @@trustedcert_files=[]
      @@clientcerts=[]
      @@clientcert_files=[]
      @@hubs=[]
      @@queues=[]
      @@conn_policies=[]
      @@msg_policies=[]
      @@topic_policies=[]
      @@topic_monitors=[]
      @@queue_policies=[]
      @@subscription_policies=[]
      @@config_policies=[]
      @@endpoints=[]
      @@sec_profiles=[]
      @@admin_endpoint=nil
      @@loglevel=nil
      @@cluster=nil
      @@ha=nil


      def whyrun_supported?
        true
      end

      def load_current_resource

        Chef::Log.debug("IMAServerAdmin provider: load_current_resource")
        @current_resource ||= Chef::Resource::IMAServerAdmin.new(new_resource.host)

        # @TODO: current resource should pull current configuration. For now set
        # to the new_resource attribute

        #setup admin config
        @current_resource.host(new_resource.host)
        @current_resource.port(new_resource.port)
        @current_resource.secure(new_resource.secure)
        @current_resource.server_name(new_resource.server_name)
        @current_resource.username(new_resource.username)
        @current_resource.password(new_resource.password)
        @current_resource.licensed_usage(new_resource.licensed_usage)
        @current_resource.accept(new_resource.accept)

        Chef::Log.debug("IMAServerAdmin provider: load_current_resource: exit")
        @current_resource

        #setup our Service helper mixins so they can communiate
        #to this instance admin host on their own. And use during our 
        #actions below
        Chef::Log.debug("IMAServerAdmin setting IMAServer Helper accessor attributes: #{new_resource.host} #{new_resource.port} #{new_resource.secure}")
        IMAServer::host=new_resource.host
        IMAServer::port=new_resource.port
        IMAServer::secure=new_resource.secure

        Chef::Log.debug("IMAServerAdmin IMAServer Helper accessor attributes: #{IMAServer::host} #{IMAServer::port} #{ IMAServer::secure}")
      end

      #Method to test connectivity to imaserver
      def action_test


        Chef::Log.debug("IMAServerAdmin provider: action_test")

        IMAServer::Helpers::Test.test

        new_resource.updated_by_last_action(true)
      end


      #Method to post all config objects
      def action_post
        """
        post multiple arrays of config objects
        """

        Chef::Log.debug("IMAServerAdmin provider: action_post")

        #setup certificate profiles first
        #before setting up profiles, need to upload cert files using put
        @@cert_files.each do |afile|
          Chef::Log.debug("IMAServerAdmin action post: cert file found: #{afile}")

          IMAServer::Helpers::File.put(afile)
        end

        #if no errors reset cert_files to empty array. 
        #Otherwise admin provider will post same objects
        #again on subsquent post
        @@cert_files=[]

        
        @@cert_profiles.each do |aprofile|
          Chef::Log.debug("IMAServerAdmin action post: cert profile found: #{aprofile}")

          IMAServer::Helpers::Config.post(aprofile)
        end

        #if no errors reset cert_profiles to empty array. 
        @@cert_profiles=[]


        #post security profiles
        @@sec_profiles.each do |aprofile|
          Chef::Log.debug("IMAServerAdmin action post: sec profile found: #{aprofile}")

          IMAServer::Helpers::Config.post(aprofile)
        end

        #if no errors reset sec_policies to empty array. 
        @@sec_profiles=[]


        #send trusted certs
        @@trustedcert_files.each do |afile|
          Chef::Log.debug("IMAServerAdmin action post: trusted cert file found: #{afile}")

          IMAServer::Helpers::File.put(afile)
        end


        #reset trusted files
        @@trustedcert_files=[]

        #send trusted certs object
        @@trustedcerts.each do |acert|
          Chef::Log.debug("IMAServerAdmin action post: trusted cert obj found: #{acert}")

          IMAServer::Helpers::Config.post(acert)
        end

        #if no errors reset cert_profiles to empty array. 
        @@trustedcerts=[]


        #send client certs
        @@clientcert_files.each do |afile|
          Chef::Log.debug("IMAServerAdmin action post: client cert file found: #{afile}")

          IMAServer::Helpers::File.put(afile)
        end


        #reset client cert files
        @@clientcert_files=[]

        #send client certs object
        @@clientcerts.each do |acert|
          Chef::Log.debug("IMAServerAdmin action post: client cert obj found: #{acert}")

          IMAServer::Helpers::Config.post(acert)
        end

        #if no errors reset cert_profiles to empty array. 
        @@clientcerts=[]


        #send post for each hub
        @@hubs.each do |ahub|
          Chef::Log.debug("IMAServerAdmin action post: hub found: #{ahub}")

          IMAServer::Helpers::Config.post(ahub)
        end

        #if no errors reset hubs to empty array. 
        @@hubs=[]

        #send post for each queue
        @@queues.each do |aqueue|
          Chef::Log.debug("IMAServerAdmin action post: queue found: #{aqueue}")

          IMAServer::Helpers::Config.post(aqueue)
        end

        #if no errors reset queues to empty array. 
        @@queues=[]

        #setup connection policies third
        @@conn_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: conn policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset conn_policies to empty array. 
        @@conn_policies=[]

        #setup message policies fourth
        @@msg_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: msg policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset msg_policies to empty array. 
        @@msg_policies=[]

        #setup topic policies fifth
        @@topic_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: topic policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset topic_policies to empty array. 
        @@topic_policies=[]

        #setup subscription policies sixth
        @@subscription_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: subscription policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset subscription_policies to empty array. 
        @@subscription_policies=[]

        #setup queue policies seventh
        @@queue_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: queue policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset hubs to empty array. 
        @@queue_policies=[]

        #setup endpoints eighth
        @@endpoints.each do |aendpoint|
          Chef::Log.debug("IMAServerAdmin action post: endpoints found: #{aendpoint}")

          IMAServer::Helpers::Config.post(aendpoint)
        end

        #if no errors reset endpoints to empty array. 
        @@endpoints=[]

        #setup config policies nineth
        @@config_policies.each do |apolicy|
          Chef::Log.debug("IMAServerAdmin action post: configiuration policies found: #{apolicy}")

          IMAServer::Helpers::Config.post(apolicy)
        end

        #if no errors reset config_policies to empty array. 
        @@config_policies=[]


        """
        setup single config objects
        """
        #setup admin endpoint tenth
        if @@admin_endpoint
          Chef::Log.debug("IMAServerAdmin action post: admin_endpoint found: #{@@admin_endpoint}")

          IMAServer::Helpers::Config.post(@@admin_endpoint)
        end

        #if no errors reset admin_endpoint to nil. 
        @@admin_endpoint=nil


        #setup loglevel
        if @@loglevel
          Chef::Log.debug("IMAServerAdmin action post: loglevel found: #{@@loglevel}")

          IMAServer::Helpers::Config.post(@@loglevel)
        end

        #if no errors reset admin_endpoint to nil. 
        @@loglevel=nil

        #setup cluster
        if @@cluster
          Chef::Log.debug("IMAServerAdmin action post: cluster found: #{@@cluster}")

          IMAServer::Helpers::Config.post(@@cluster)
        end
        #if no errors reset cluster to nil. 
        @@cluster=nil

        #setup monitors
        @@topic_monitors.each do |amonitor|
          Chef::Log.debug("IMAServerAdmin action post: topic monitors found: #{apolicy}")

          IMAServer::Helpers::Config.post(amonitor)
        end

        #if no errors reset topic_monitors to empty array. 
        @@topic_monitors=[]


        #setup ha
        if @@ha
          Chef::Log.debug("IMAServerAdmin action post: ha found: #{@@ha}")

          IMAServer::Helpers::Config.post(@@ha)
        end

        #if no errors reset ha to nil. 
        @@ha=nil

        #call accept license if defined
        if new_resource.accept == true && new_resource.licensed_usage != ""
          action_acceptlic
        else
          #otherwise we're done
          new_resource.updated_by_last_action(true)
        end
      end

      def action_restart


        Chef::Log.debug("IMAServerService provider: action_restart")
        
        service_obj = {new_resource.SERVICE_TYPE => new_resource.server_name}
        
        #we are restarting so add to url context and push obj restart json
        IMAServer::Helpers::Service.restart(service_obj)

        new_resource.updated_by_last_action(true)
      end

      def action_acceptlic

        #setup license usage

        Chef::Log.debug("accept license provider: action_post")
        
        json_obj = { new_resource.LICENSEDUSAGE_TYPE => new_resource.licensed_usage,
            new_resource.ACCEPT_TYPE => new_resource.accept
          }

        Chef::Log.debug("accept license provider: json_obj: #{json_obj}")
        json_payload = Chef::JSONCompat.to_json_pretty(json_obj)

        Chef::Log.debug("accept license: json_payload: #{json_payload}")

        acceptlic=json_obj


        #send licensed acceptence
        if acceptlic
          Chef::Log.debug("IMAServerAdmin action post: accept license found: #{acceptlic}")

          IMAServer::Helpers::Config.post(acceptlic)
        end

        #lets block until server is back up from restart
        if action_pollserver("Running") == false
          Chef::Log.error("Server timeout during license acceptence restart")
          new_resource.updated_by_last_action(false)
        else
          new_resource.updated_by_last_action(true)
        end
      end

      """
      @TODO action_pollserver should be moved to helpers.rb within IMAServer module so that any resource or 
      provider can use
      """
      def action_pollserver(status,state=nil,role=nil)
        sleep_timeout = 300
        sleep_interval = 10
        reconn_interval = 10
    
        total_sleep=0

        Chef::Log.debug( "Start poll_state...\n")

        #loop until node reaches
        begin
          #sleep before polling
          sleep sleep_interval
          total_sleep += sleep_interval


          #in cases of a server start taking a long time, connections will fail for service requests
          #lets retry status if server is not fully up yet
          begin
            node_state=IMAServer::Helpers::Service.status
          rescue Errno::ECONNREFUSED
            sleep reconn_interval
            total_sleep +=reconn_interval
            if total_sleep > sleep_timeout
              Chef::Log.debug("Error: server: #{IMAServer::Helpers::host} with port #{IMAServer::Helpers::port} refused network connection ... server in bad state\n")
              Chef::Log.debug("End poll_state...return false\n")
              return false
            else
              Chef::Log.debug("Warning: retrying to retrive status for #{IMAServer::Helpers::host} with port #{IMAServer::Helpers::port}\n")
              retry
            end
          end
          
          Chef::Log.debug("cluster_upgrade: poll_state: polling node for status: #{status} state: #{state} role: #{role}\n")
          Chef::Log.debug("cluster_upgrade: poll_state: current status: --->\n #{node_state}\n<---\n")
          
          hash_state=JSON.parse(node_state)
          
          ha_state=hash_state["HighAvailability"]
          server_status=hash_state["Server"]
          
          Chef::Log.debug("cluster: debug: polling server_status: #{server_status["Status"]} server_state: #{server_status["StateDescription"]} match_status: #{if status then server_status["Status"].include?(status) else false end} match_state: #{if state then server_status["StateDescription"].include?(state) else false end} role_status: #{ha_state["NewRole"]} role_match: #{ha_state["NewRole"] == role}\n")


          if total_sleep >= sleep_timeout
            Chef::Log.debug("cluster_upgrade: We have timeout waiting on server to become status: #{status} role: #{role}\n")
            Chef::Log.debug("End poll_state...return false\n")

            return false
          end

        end until (if role and state and status 
                     (ha_state["NewRole"] == role && (server_status["StateDescription"].include?(state)) && (server_status["Status"].include?(status))) 
                   elsif state and status 
                     ((server_status["StateDescription"].include?(state)) && (server_status["Status"].include?(status))) 
                   else (server_status["Status"].include?(status))
                   end)
        
        Chef::Log.debug("End poll_state...return true\n")

        #we reached state returne true
        return true
      end

      def action_delete
        # @TODO impelment delete action

        Chef::Log.debug("IMAServerAdmin provider: action_delete")
        new_resource.updated_by_last_action(true)
      end


    end
  end
end
