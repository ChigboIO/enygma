require "spec_helper"

describe Enygma::Encryptor do
  describe "#new" do
    context "when instantiating the Encryptor class" do
      context "when output file name is provided" do
        subject do
          Enygma::Encryptor.new("test.txt", "encrypted.txt")
        end

        it "should accept TWO parameters" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Encryptor class" do
          expect(subject).to be_an_instance_of(Enygma::Encryptor)
        end

        it "should set the filename to the first parameter" do
          expect(subject.filename).to eql("test.txt")
        end

        it "should set the cypher filename to the second parameter" do
          expect(subject.cypher_filename).to eql("encrypted.txt")
        end
        
        it "should generate 5 digits key" do
          expect(subject.encryption_key.length).to eql(5)
        end

        it "should generate 4 digits offset" do
          expect(subject.offset.length).to eql(4)
        end
      end

      context "when output file name is NOT provided" do
        subject do
          Enygma::Encryptor.new('test.txt')
        end

        it "should accept ONE parameters" do
          expect { subject }.to_not raise_error
        end

        it "should be an instance of Encryptor class" do
          expect(subject).to be_an_instance_of(Enygma::Encryptor)
        end

        it "should set the filename to the first parameter" do
          expect(subject.filename).to eql("test.txt")
        end

        it "should set the cypher filename to the second parameter" do
          expect(subject.cypher_filename).to be_nil
        end
      end

      context "when no argument is provided" do
        it "should NOT accept ZERO parameters" do
          expect { Enygma::Encryptor.new }.to raise_error(ArgumentError)
        end
      end

      context "when THREE arguments are provided" do
        it "should NOT accept more than two parameters" do
          expect { Enygma::Encryptor.new("arg1", "arg2", "arg3") }.
              to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "#encrypt" do
    context "when the #encrypt method is called" do
      context "when the output filename is not given" do
        subject do
          Enygma::Encryptor.new("default.txt")
        end

        it "should generate the cypher_filename from the source filename" do
          subject.encrypt
          expect(subject.cypher_filename).to eql("default.encrypted.txt")
          File.delete("default.encrypted.txt")
        end

        it "should create a file with name 'default.encrypted.txt'" do
          subject.encrypt
          expect(File.exist?("default.encrypted.txt")).to be_truthy
          File.delete("default.encrypted.txt")
        end
      end

      context "when the output filename is given" do
        subject do
          Enygma::Encryptor.new("default.txt", "enc.txt")
        end

        it "should create a file with name 'enc.txt'" do
          subject.encrypt
          expect(File.exist?("enc.txt")).to be_truthy
          File.delete("enc.txt")
        end
      end

    end
  end
end