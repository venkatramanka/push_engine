require_dependency "pusher/application_controller"

module Pusher
  class PushController < ApplicationController
  	@@clients = []
	@@hClients = Hash.new{|hash, key| hash[key] = Array.new}
	@@hTokens = Hash.new
	@@count=0
	@user = ""
	EventMachine.run do
  		EM::WebSocket.run(:host => '0.0.0.0', :port => '3001') do |ws|
    		ws.onopen do |handshake|
      			@@clients << ws
    		end
		    ws.onclose do
      			@@hClients.delete_if{|key,val| val==ws}
      			@@clients.delete ws
    		end
		    ws.onmessage do |msg|
          @@hClients[msg] << ws
          ws.send("Connected as #{msg}")
    		end
  		end
  		def push_frame
        @hex = (@@hTokens[params[:uname]] ||= SecureRandom.hex)
  		end

      def recepients
        @@hClients[params[:msg_to]]+@@hClients[params[:msg_from]]
      end

  		def send_msg
  			recepients.each{|ws| ws.send(params[:msg_from] + " : " + params[:msg])} if params[:token] = @@hTokens[params[:msg_from]]
  			render nothing: true
  		end
	end
  end
end
