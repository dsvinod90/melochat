
require 'test_helper'

class Services::RequestTest < ActiveSupport::TestCase
    test 'returns nil for response when request timesout' do
        stub_request(:get, 'https://api.covid19api.com/total/country/india').to_timeout

        service = Services::Request.get('https://api.covid19api.com/total/country/india')
        assert_nil service
    end
end