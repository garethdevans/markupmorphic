require 'rubygems'
require 'sinatra'
require 'rack'

use Rack::Session::Cookie, :key => 'rack.session',
                          :path => '/',
                          :expire_after => 60 * 60 * 1, # In seconds
                          :secret => 'open_sesame'

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
#$stdout.reopen(log)
$stderr.reopen(log)


root_dir = File.dirname(__FILE__)
require File.join(root_dir, 'main')

set :environment, :production
set :root,  root_dir
set :app_file, File.join(root_dir, 'main.rb')
disable :run

run Markupmorphic::Main
