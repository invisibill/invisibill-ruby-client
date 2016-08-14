require 'active_support/core_ext/date_time/calculations'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/numeric/time'
require 'base64'
require 'json'
require 'invisibill-ruby-client/version'
require 'invisibill-ruby-client/api_client'
require 'invisibill-ruby-client/models/model'
require 'invisibill-ruby-client/models/contract'
require 'invisibill-ruby-client/models/entity'
require 'invisibill-ruby-client/models/invoice'
require 'invisibill-ruby-client/models/location'
require 'invisibill-ruby-client/models/resource'
require 'invisibill-ruby-client/models/timecard'
require 'invisibill-ruby-client/models/token'

require 'pry'

module Invisibill
  INVISIBILL_API_TOKEN = ENV['INVISIBILL_API_TOKEN'] || (raise ArgumentError.new('INVISIBILL_API_TOKEN environment variable must be set'))
end
