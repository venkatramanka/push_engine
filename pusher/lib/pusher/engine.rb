require 'thin'
require 'sinatra/base'
require 'em-websocket'

module Pusher
  class Engine < ::Rails::Engine
    isolate_namespace Pusher
  end
end
