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

# IMAServer admin module
Chef::Log.debug("Loading imaserveradmin helper")



module IMAServer
   # need access attrs for hostname and port base on provider instance
   # these attrs will be setup by provider_admin during dsl. Essentially this
   # module's communications depend on provider_admin.rb to setup where communications
   # should be routed to(or really any class that includes this module)
   attr_accessor :host,:port,:secure

   module Helpers
     SLEEP_TIMEOUT = 300
     SLEEP_INTERVAL = 10
     RECONN_INTERVAL = 1

     #define HTTP methods to communicate to imaserver

     # Exception declaration
     class IMAServerNotResponding < StandardError
       def initialize(timeout)
           super <<-EOH
The imaserver did not respond within #{timeout} seconds
EOH
       end
     end

     #post method
     def Helpers.rest_post(conn,hashobj)
       Chef::Log.debug("IMAServerAdmin provider: post")
       
       Chef::Log.debug("Sending POST to: #{conn} #{hashobj.to_json}")
       conn.post(hashobj.to_json, :content_type => :json, :accept => :json) do |response,request,result, &block|
         

         if response.code !=200
           Chef::Log.error("Post to #{conn.url} Failed with: #{response.code}\n Error Response page: #{response.to_str} Request Headers: #{request.headers} Request Payload: #{request.payload} Result: #{result}")
         else
           Chef::Log.info("Post to #{conn.url} Succeeded with: #{response.code}\n Response page: #{response.to_str}")
         end
        end
       
     end

     #put file method
     def Helpers.rest_put(conn,fileobj)
       Chef::Log.debug("IMAServer provider: put")
       #retrive actual filename and addit to url
       filename = Chef::File.basename(fileobj)
       Chef::Log.debug("Sending PUT to: #{conn.url+"/"+filename} #{Chef::File.read(fileobj)}")
       #going to save original file uri context since we temporary modify
       #it and add filename to uri
       
       conn[filename].put(Chef::File.read(fileobj)) do |response,request,result, &block|
         
         
         if response.code !=200
           Chef::Log.error("Put to #{conn.url+"/"+filename} Failed with: #{response.code}\n Error Response page: #{response.to_str}")
         else
           Chef::Log.info("Put to #{conn.url+"/"+filename} Succeeded with: #{response.code}\n Response page: #{response.to_str}")
         end

       end
       
     end

     #get method
     def Helpers.rest_get(conn)
       
       Chef::Log.debug("IMAServer provider: get")
       
       Chef::Log.debug("Sending GET to: #{conn}")
       conn.get do |response,request,result, &block|
         
         if response.code !=200
           Chef::Log.error("Get to #{conn.url} Failed with: #{response.code}\n Error Response page: #{response.to_str} Request Headers: #{request.headers} Request Payload: #{request.payload} Result: #{result}")
         else
           Chef::Log.info("Get to #{conn.url} Succeeded with: #{response.code}\n Response page: #{response.to_str}")
           #convert reponse to json structure
#           return Chef::JSONCompat.to_json(response.body)
           return response.body
         end
       end
         
     end

     module Test

       @@Root_URI='/'

       def Test.test
        
         #To test just send a get request to root context

         Chef::Log.debug("Going to test connection: #{IMAServer::host}:#{IMAServer::port}")

         if @secure
           test_url = 'https://'+IMAServer::host+':'+"#{IMAServer::port}"+@@Root_URI
         else
           test_url = 'http://'+IMAServer::host+':'+"#{IMAServer::port}"+@@Root_URI
         end
         Chef::Log.debug("Sending test to: #{test_url}")

         #Create reset resouce (ie connection) to server
         #
         #WARNING: these calls will not verify imaserver certificate. Extra setup
         #required
         #
         test_conn = RestClient::Resource.new(test_url,:verify_ssl => false)
         total_sleep = 0
         begin
           payload=Helpers.rest_get(test_conn)
         rescue Errno::ECONNREFUSED
           sleep Helpers::RECONN_INTERVAL
           total_sleep += Helpers::RECONN_INTERVAL
           if total_sleep > Helpers::SLEEP_TIMEOUT
             Chef::Log.debug("Error: #{test_url} refused network connection ... host in bad state\n")
             Chef::Log.debug("End poll_state...return false\n")
             return false
           else
             Chef::Log.debug("Warning: ECONNREFUSED retrying to retrive status for #{test_url} current total_sleep: #{total_sleep}secs\n")
             retry
           end

         end


         Chef::Log.debug("Received test response to: #{payload}")
         
       end

     end

     module Config

       @@CONFIG_URI = '/ima/v1/configuration'

       def Config.post(json_obj)
         #To test just send a get request to root context
         if @secure
           config_url = 'https://'+IMAServer::host+':'+"#{IMAServer::port}"+@@CONFIG_URI
         else
           config_url = 'http://'+IMAServer::host+':'+"#{IMAServer::port}"+@@CONFIG_URI
         end
         Chef::Log.debug("Sending config post to: #{config_url}")

         #Create rest resouce (ie connection) to server
         #
         #WARNING: these calls will not verify imaserver certificate. Extra setup
         #required
         #
         conn = RestClient::Resource.new(config_url,:verify_ssl => false)
         total_sleep = 0
         begin
           Helpers.rest_post(conn,json_obj)
         rescue Errno::ECONNREFUSED
           sleep Helpers::RECONN_INTERVAL
           total_sleep += Helpers::RECONN_INTERVAL
           if total_sleep > Helpers::SLEEP_TIMEOUT
             Chef::Log.debug("Error: #{config_url} refused network connection ... node in bad state\n")
             Chef::Log.debug("End poll_state...return false\n")
             return false
           else
             Chef::Log.debug("Warning: ECONNREFUSED retrying to retrive status for #{config_url} current total_sleep: #{total_sleep}secs\n")
             retry
           end

         end
       end
     end

     module File

       @@FILE_URI = '/ima/v1/file'

       def File.put(fileobj)

         if @secure
           file_url = 'https://'+IMAServer::host+':'+"#{IMAServer::port}"+@@FILE_URI
         else
           file_url = 'http://'+IMAServer::host+':'+"#{IMAServer::port}"+@@FILE_URI
         end
         Chef::Log.debug("Sending file put to: #{file_url}")

         #Create rest resouce (ie connection) to server
         #
         #WARNING: these calls will not verify imaserver certificate. Extra setup
         #required
         #
         conn = RestClient::Resource.new(file_url,:verify_ssl => false)
         Helpers.rest_put(conn,fileobj)
       end
     end

     module Service
       #
       # Service module is used to send requests to various imaserver service endpoints
       #

       #define root service uri
       @@SERVICE_URI = '/ima/v1/service'

       Chef::Log.debug("IMAServer::Helpers::Service: entered")
       #Here is status schema:
       #
       #{ "Version":"v1",
       #  "Server":{ "Name":"(null)","State":1,"StateDescription":"Status = Running (production)","ErrorCode ":0,"UpTimeSeconds":4948,"UpTimeDescription":"0 days 1 hours 22 minutes 28 seconds","Version":"V.next Beta 20150831-1908","ErrorMessage":""},  "Container": {"UUID":"c3ab599f-556a-e5b1-3928-f7c2ce9c50df"},  "HighAvailability": {"Role":"HADISABLED","IsHAEnabled":0,"NewRole":"HADISABLED","OldRole":"HADISABLED","ActiveNodes":0,"SyncNodes":0,"PrimaryLastTime":"2015-09-02 22:42:58Z","PctSyncCompletion":0,"ReasonCode":0,"ReasonString":""},  "Cluster": {"ClusterState": "Disabled" }}
       def Service.status(server=nil,aport=0)
         #if no args passed in use IMAServerAdmin setting
         server=IMAServer::host unless server
          aport=IMAServer::port unless aport > 0

         #To test just send a get request to root context
         Chef::Log.debug("IMAServerService provider: action_status")
         if @secure
           service_url = 'https://'+server+':'+"#{aport}"+@@SERVICE_URI
         else
           service_url = 'http://'+server+':'+"#{aport}"+@@SERVICE_URI
         end

         Chef::Log.debug("Sending service status to: #{service_url}")
         service_conn = RestClient::Resource.new(service_url,:verify_ssl => false)
         
         
         #we are requesting status, add to url
         astatus = Helpers.rest_get(service_conn['status'])
         
       end

       def Service.restart(service_obj)
         #To test just send a get request to root context
         if @secure
           service_url = 'https://'+IMAServer::host+':'+"#{IMAServer::port}"+@@SERVICE_URI
         else
           service_url = 'http://'+IMAServer::host+':'+"#{IMAServer::port}"+@@SERVICE_URI
         end
         Chef::Log.debug("Sending service restart to: #{service_url}")

         #Create rest resouce (ie connection) to server
         #
         #WARNING: these calls will not verify imaserver certificate. Extra setup
         #required
         #
         conn = RestClient::Resource.new(service_url,:verify_ssl => false)

         #add restart context to service uri
         Helpers.rest_post(conn['restart'],service_obj)  

       end

     end
   end
 end     


