require 'rubygems'

class PrjfileFinder
  def find_from(file)
    begin
      dir = File.dirname file
      Dir.chdir dir
      begin
        matches = Dir.glob('*.csproj')
        return File.absolute_path(matches[0]) if matches.length > 0

        lst_dir = Dir.pwd
        Dir.chdir '..'
      end while lst_dir != Dir.pwd

      return nil
    rescue
      return nil
    end
  end
end
