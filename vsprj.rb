require_relative './lib/prjfile.rb'
require_relative './lib/prjfile_finder.rb'

file = ARGV[0]
finder = PrjfileFinder.new
prjfile_name = finder.find_from file
if not prjfile_name
  exit
end
prjfile = Prjfile.new( File.open( prjfile_name, 'r') )
prjfile.add(file)
File.open(prjfile_name, 'w') { |f| f.puts prjfile.text }
