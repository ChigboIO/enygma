require "spec_helper"

describe Enygma do
  describe Enygma::Filer do
    describe ".write" do
      context "when first parameter is not nil" do
        subject do
          Enygma::Filer.write("file1.txt", "some content")
        end

        before(:each) do
          subject
        end
        
        it "should return the first argument" do
          expect(subject).to eql("file1.txt")
        end

        it "should create a file with filename 'file.txt'" do
          expect(File.exist?("file1.txt")).to be_truthy
        end

        it "and the file should have content 'some content'" do
          expect(File.open("file1.txt", "r").read).to eql("some content")
        end
      end

      context "when 'destination filename' is nil" do
        context "when filename does not contain 'encrypted'" do
          subject do
            Enygma::Filer.write(nil, "some content", "file2.txt", "encrypted")
          end

          before(:each) do
            subject
          end

          it "should combine the source filename and the action" do
            expect(subject).to eql("file2.encrypted.txt")
          end

          it "should create a file with filename 'file2.txt'" do
            expect(File.exist?("file2.encrypted.txt")).to be_truthy
          end

          it "should have content 'some content'" do
            expect(File.open("file2.encrypted.txt", "r").read).
                to eql("some content")
          end
        end
        context "when filename contains 'encrypted'" do

          it "should replace the 'encrypted' with the 'decrypted'" do
            expect(Enygma::Filer.write(nil, "some content",
                                       "file3.encrypted.txt", "decrypted"
            )).to eql("file3.decrypted.txt")
          end

          it "should replace the 'encrypted' with the 'cracked'" do
            expect(Enygma::Filer.write(nil, "some content",
                                       "file3.encrypted.txt", "cracked"
            )).to eql("file3.cracked.txt")
          end
        end
      end
    end
  end
end