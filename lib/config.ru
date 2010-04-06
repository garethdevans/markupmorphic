require 'rubygems'
require 'sinatra'
require 'rack'
require 'main'

use Rack::Session::Cookie, :key => 'rack.session',
                          :path => '/',
                          :expire_after => 60 * 60 * 12, # In seconds
                          :secret => 'change_me'
         
Main.run! :host => 'localhost', :port => 4567
