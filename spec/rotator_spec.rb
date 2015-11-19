require "spec_helper"

describe Enygma do
  describe Enygma::Rotator do
    describe ".rotate" do
      context "when given '9, 23, 8, 'd', :+'" do
        it "should return 54078" do
          expect(Enygma::Rotator.rotate("9", "23", "8", "d", :+)).to eql(37)
        end
      end
    end
  end
end