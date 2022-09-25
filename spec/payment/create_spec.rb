# frozen_string_literal: true

RSpec.describe Kassa24::Payment::Create do
  describe "#call" do
    let(:endpoint) { "https://ecommerce.pult24.kz/payment/create" }
    let(:login) { ENV.fetch("KASSA24_TEST_LOGIN", "NO_LOGIN_PROVIDED") }
    let(:password) { ENV.fetch("KASSA24_TEST_PASSWORD", "NO_PASSWORD_PROVIDED") }
    let(:authorization) { Base64.encode64("#{login}:#{password}").strip }

    before do
      if ENV["ENABLE_REAL_REQUESTS"]
        WebMock.allow_net_connect!
      else
        stub_payment_create_200
        stub_payment_create_400
        stub_payment_create_401
      end
    end

    context "with not all required fields provided" do
      it "raises ArgumentError" do
        expect { subject.call(login: "bad_login", password: "bad_password") }
          .to raise_error(ArgumentError)
          .with_message("Missing required fields [:amount]")
      end
    end

    context "with unknown fields provided" do
      it "raises ArgumentError" do
        expect { subject.call(login: "bad_login", password: "bad_password", amount: 100_00, unknown_field: "xxx") }
          .to raise_error(ArgumentError)
          .with_message("Unknown fields [:unknown_field]")
      end
    end

    context "with bad auth" do
      let(:result) { subject.call(login: "bad_login", password: "bad_password", amount: 100_00) }

      it "fails" do
        expect(result.success?).to eq(false)
      end

      it "returns :bad_credentails error" do
        expect(result.error).to eq([:bad_credentials, {}])
      end
    end

    context "with correct auth" do
      let(:result) { subject.call(login: login, password: password, amount: 0) }

      context "with bad data provided" do
        it "fails" do
          expect(result.success?).to eq(false)
        end

        it "returns :bad_credentails error" do
          expect(result.error).to eq(
            [
              :bad_data,
              {
                message: "Error validating request: \"amount\" is required and should be larger than 0"
              }
            ]
          )
        end
      end

      context "with correct data provided" do
        let(:result) { subject.call(login: login, password: password, amount: 100_00) }

        it "succeeds" do
          expect(result.success?).to eq(true)
        end

        it "returns payment_id" do
          expect(result.value[:id]).to be_a(String)
          expect(result.value[:url]).to be_a(String)
        end
      end
    end
  end
end
