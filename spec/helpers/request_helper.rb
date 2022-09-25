module RequestHelper
  def stub_payment_create_200
    stub_request(:post, endpoint)
    .with(
      body: { "{\"amount\":10000,\"merchantId\":\"13812990844141623\"}" => nil },
      headers: {
        "Accept" => "*/*",
        "Authorization" => "Basic #{authorization}"
      }
    ).to_return(status: 200, body: File.read("spec/fixtures/payment/create/200.json"), headers: {})
  end

  def stub_payment_create_400
    stub_request(:post, endpoint)
    .with(
      body: "{\"amount\":0,\"merchantId\":\"13812990844141623\"}",
      headers: {
        "Accept" => "*/*",
        "Authorization" => "Basic #{authorization}"
      }
    ).to_return(status: 400, body: File.read("spec/fixtures/payment/create/400.txt"), headers: {})
  end

  def stub_payment_create_401
    stub_request(:post, endpoint)
    .with(
      body: "{\"amount\":10000,\"merchantId\":\"bad_login\"}",
      headers: {
        "Accept" => "*/*",
        "Authorization" => "Basic YmFkX2xvZ2luOmJhZF9wYXNzd29yZA=="
      }
    ).to_return(status: 401, body: File.read("spec/fixtures/payment/create/401.json"), headers: {})
  end
end
