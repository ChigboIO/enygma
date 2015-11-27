require "spec_helper"

describe Enygma::Cracker do
  describe "#initialize" do
    context "when instantiating the Cracker class" do
      context "when output file name is provided" do
        subject do
          Enygma::Cracker.new("encrypted.txt", "plain.txt", "231190")
        end

        it "should NOT raise an error for three parameters" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Cracker class" do
          expect(subject).to be_an_instance_of(Enygma::Cracker)
        end

        it "should set the PLAIN filename to 'plain.txt'" do
          expect(subject.plain_filename).to eql("plain.txt")
        end

        it "should set the cypher filename to 'encryption.txt'" do
          expect(subject.cypher_filename).to eql("encrypted.txt")
        end

        it "should set the encryption date to be '231190'" do
          expect(subject.encryption_date).to eql("231190")
        end
      end

      context "when TWO parameters are given" do
        subject do
          Enygma::Cracker.new('encrypted.txt', "231190")
        end

        it "should NOT raise an error" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Cracker class" do
          expect(subject).to be_an_instance_of(Enygma::Cracker)
        end

        it "should set the plain filename to nil" do
          expect(subject.plain_filename).to be_nil
        end
      end

      context "when no argument is provided" do

        it "should Raise ArgumentError " do
          expect { Enygma::Cracker.new }.to raise_error(ArgumentError)
        end
      end

      context "when FOUR arguments are provided" do

        it "should raise ArgumentError" do
          expect { Enygma::Cracker.new("arg1", "arg2", "arg3", "arg4") }.
            to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "#crack" do
    context "when the #crack method is called" do
      context "when the output filename is not given" do
        subject do
          Enygma::Cracker.new("default_enc.txt", "271115")
        end

        it "should generate the encryption key" do
          subject.crack
          expect(subject.key).to eql("96545")
          File.delete("default_enc.cracked.txt")
        end

        it "should generate file content of 'some default content ..end..'" do
          subject.crack
          expect(File.open("default_enc.cracked.txt", 'r').read).
            to eql("some default content ..end..")
        end
      end
    end
  end
end