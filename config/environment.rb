# Load the rails application
require File.expand_path('../application', __FILE__)
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Maass2::Application.initialize!

