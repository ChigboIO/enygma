module Enygma
  class Filer
    def self.read(filename)
      content = File.open(filename, 'r') { |file| file.read }
      content.split('')
    end

    # TODO: use options params instead
    def self.write(dest_file, content, source_file = '', action = '')
      unless dest_file
        name_split = source_file.split('.')
        name_split.delete("encrypted")
        dest_file = name_split.insert(-2, action).join('.')
      end

      File.open(dest_file, "w") { |file| file.write(content) }
      dest_file
    end
  end
end