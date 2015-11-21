require "spec_helper"

describe Enygma do
  describe Enygma::KeyGen do
    describe ".get_key" do
      context "when given '[54, 12, 09, 78]'" do
        it "should return 54078" do
          expect(Enygma::KeyGen.get_key(%w(54 12 09 78))).
              to eql("54078")
        end
      end
    end
  end
end