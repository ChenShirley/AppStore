# This file is used by Rack-based servers to start the application.

# Following line tells rackup to use Puma as the web server
#\ -s puma

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
