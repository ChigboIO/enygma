require "spec_helper"

describe Enygma::Decryptor do
  describe "#initialize" do
    context "when instantiating the Decryptor class" do
      context "when output file name is provided" do
        subject do
          Enygma::Decryptor.new("encrypted.txt", "12345", "231190", "plain.txt")
        end

        it "should NOT raise an error" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Decryptor class" do
          expect(subject).to be_an_instance_of(Enygma::Decryptor)
        end

        it "should set the PLAIN filename to 'plain.txt'" do
          expect(subject.plain_filename).to eql("plain.txt")
        end

        it "should set the cypher filename to 'encryption.txt'" do
          expect(subject.cypher_filename).to eql("encrypted.txt")
        end

        it "should set the encryption key to '12345'" do
          expect(subject.encryption_key).to eql("12345")
        end

        it "should set the encryption date to be '231190'" do
          expect(subject.encryption_date).to eql("231190")
        end
      end

      context "when THREE parameters are given" do
        subject do
          Enygma::Decryptor.new('encrypted.txt', "12345", "231190")
        end

        it "should NOT raise an error" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Decryptor class" do
          expect(subject).to be_an_instance_of(Enygma::Decryptor)
        end

        it "should set the plain filename to nil" do
          expect(subject.plain_filename).to be_nil
        end
      end

      context "when no argument is provided" do

        it "should Raise ArgumentError " do
          expect { Enygma::Decryptor.new }.to raise_error(ArgumentError)
        end
      end

      context "when FIVE arguments are provided" do

        it "should raise ArgumentError" do
          expect { Enygma::Encryptor.new("arg1", "arg2", "arg3") }.
            to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "#decrypt" do
    context "when the #decrypt method is called" do
      context "when the output filename is not given" do
        subject do
          Enygma::Decryptor.new("default_enc.txt", "57999", "201115")
        end

        it "should generate the plain filename from the cypher filename" do
          subject.decrypt
          expect(subject.plain_filename).to eql("default_enc.decrypted.txt")
          File.delete("default_enc.decrypted.txt")
        end

        it "should generate the plain file content of 'some default content'" do
          subject.decrypt
          expect(File.open("default_enc.decrypted.txt", 'r').read).
            to eql("some default content")
        end
      end
    end
  end
end