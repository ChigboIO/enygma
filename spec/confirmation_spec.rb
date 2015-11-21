require "spec_helper"

describe Enygma do
  describe Enygma::Confirmation do
    describe ".show_confirmation_message" do
      context "when given 'file.txt', '12345', '231190'" do
        it "should return 'created file.txt with key 12345 and date 231190'" do
          expect(STDOUT).to receive(:puts).
              with("created file.txt with key 12345 and date 231190")
          Enygma::Encryptor.new("default.txt").show_confirmation_message(
              'file.txt', '12345', '231190'
          )
        end
      end
    end
  end
end