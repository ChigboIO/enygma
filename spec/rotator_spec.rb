require "spec_helper"

describe Enygma do
  describe Enygma::Rotator do
    describe ".rotate" do
      context "when given '9, 23, 8, 'd' with block  '{ |x, y| x + y }'" do
        it "should return 4" do
          expect(Enygma::Rotator.rotate("9", "23", "8", "d") { |x, y| x + y }).
            to eql(4)
        end
        end
      context "when given '9, 23, 8, 'd' with block  '{ |x, y| x - y }'" do
        it "should return 63" do
          expect(Enygma::Rotator.rotate("9", "23", "8", "d") { |x, y| x - y }).
            to eql(63)
        end
      end
    end
  end
end