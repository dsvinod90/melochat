# frozen_string_literal: true

require('test_helper')

module Services
  class RequestTest < ActiveSupport::TestCase
    test 'returns nil for response when request timesout' do
      stub_request(:get, 'https://api.covid19api.com/total/country/india').to_timeout

      service = Services::Request.get('https://api.covid19api.com/total/country/india')
      assert_nil service
    end
  end
end
