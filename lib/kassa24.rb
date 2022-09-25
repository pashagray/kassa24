# frozen_string_literal: true
require "faraday"

require_relative "kassa24/version"
require_relative "kassa24/request"
require_relative "kassa24/result"
require_relative "kassa24/payment/create"

module Kassa24
  class Error < StandardError; end
end
