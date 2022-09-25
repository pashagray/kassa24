module Kassa24
  class Result
    attr_reader :error, :value

    def initialize(response)
      body = response.body.gsub(/Field "([a-zA-Z]+)"/, '\"\1\"') # unescape bad json
      @value = JSON.parse(body, symbolize_names: true)

      @error = [:bad_credentials, {}] if response.status == 401
      @error = [:bad_data, { message: @value[:error] }] if response.status == 400
    end

    def success?
      @error.nil?
    end
  end
end
