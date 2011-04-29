require_relative 'prjfile.rb'
require_relative 'prjfile_finder.rb'

class CommandRunner
  def run(args)
    command = args[0]
    case command
    when 'add'
      add(args[1])
    when 'remove'
      remove(args[1])
    end
  end

  def add(file)
    prjfile_name, prjfile = find_prjfile file
    return unless prjfile

    prjfile.add(file)

    write_prjfile(prjfile_name, prjfile)
  end

  def remove(file)
    prjfile_name, prjfile = find_prjfile file
    return unless prjfile
    
    prjfile.remove(file)

    write_prjfile(prjfile_name, prjfile)
  end

  def find_prjfile(file)
    finder = PrjfileFinder.new
    prjfile_name = finder.find_from file
    return nil unless prjfile_name

    prjfile = Prjfile.new(File.open(prjfile_name, 'r'))
    return prjfile_name, prjfile
  end

  def write_prjfile(file_name, prjfile)
    File.open(file_name, 'w') { |f| f.puts prjfile.text }
  end
end
