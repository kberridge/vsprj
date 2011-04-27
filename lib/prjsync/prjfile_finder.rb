require 'rubygems'

module Prjsync
  class PrjfileFinder
    def find_from(file)
      dir = File.dirname file
      Dir.chdir dir
      begin
        matches = Dir.glob('*.csproj')
        return build_full_windows_file_path(matches[0]) if matches.length > 0

        lst_dir = Dir.pwd
        Dir.chdir '..'
      end while lst_dir != Dir.pwd

      return nil
    end

    def build_full_windows_file_path(file)
      File.join(Dir.pwd, file).gsub('/','\\') 
    end
  end
end