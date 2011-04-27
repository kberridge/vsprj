require_relative './lib/prjsync.rb'

file = ARGV[0]
finder = Prjsync::PrjfileFinder.new
prjfile = finder.find_from file
prj = Prjsync::Prjfile.new( File.open( prjfile, 'r') )
prj.add(file)
File.open(prjfile, 'w') { |f| f.puts prj.text }
