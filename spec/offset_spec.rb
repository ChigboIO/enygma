require "spec_helper"

describe Enygma do
  describe Enygma::Offset do
    describe ".get_offset" do
      context "when given '231190'" do
        it "should return 2345" do
          expect(Enygma::Offset.get_offset("231190")).to eql("6100")
        end
      end
    end
  end
end