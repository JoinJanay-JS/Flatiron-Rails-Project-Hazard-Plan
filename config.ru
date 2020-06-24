# This file is used by Rack-based servers to start the application.
require 'omniauth'
require 'omniauth-google-oauth2'
require_relative 'config/environment'

run Rails.application
