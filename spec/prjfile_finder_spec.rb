require_relative '../lib/prjfile_finder'

describe PrjfileFinder do
  before :all do
    Dir.mkdir('./prjsync') unless Dir.exists? './prjsync'
    Dir.mkdir('./prjsync/testA') unless Dir.exists? './prjsync/testA'
    Dir.mkdir('./prjsync/testA/testB') unless Dir.exists? './prjsync/testA/testB'
    File.open('./prjsync/testA/myfile.csproj', 'w') { |f| f.puts 'Some file' }
  end

  it "finds file" do
    finder = PrjfileFinder.new
    found = finder.find_from './prjsync/testA/testB/fakefile.cs'
    found.should match /.*\/prjsync\/testA\/myfile.csproj/
  end

  it "returns nil if path does not exist" do
    finder = PrjfileFinder.new
    found = finder.find_from './nothing/to/find.cs'
    found.should be_nil
  end

  it "returns nil if no prj file found" do
    finder = PrjfileFinder.new
    found = finder.find_from './prjsync/file.cs'
    found.should be_nil
  end
end 
