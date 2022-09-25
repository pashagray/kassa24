# frozen_string_literal: true

RSpec.describe Kassa24::Payment::Callback do
  describe "#call" do
    context "when IP is not in whitelist" do
      it "raises Kassa24::Error" do
        expect { subject.call(ip: "1.1.1.1") }
          .to raise_error(Kassa24::Error)
          .with_message("Bad IP address 1.1.1.1")
      end
    end

    context "when IP is in whitelist" do
      it "returns snakeized params" do
        expect(subject.call(ip: "35.157.105.64", orderId: "123", amount: 100_00))
          .to eq({ order_id: "123", amount: 100_00 })
      end
    end
  end
end
