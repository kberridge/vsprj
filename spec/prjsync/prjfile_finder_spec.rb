require 'spec_helper'

module Prjsync
  describe PrjfileFinder do
    before :all do
      Dir.mkdir('C:\\prjsync\\') unless Dir.exists? 'C:\\prjsync'
      Dir.mkdir('C:\\prjsync\\testA\\') unless Dir.exists? 'C:\\prjsync\\testA'
      Dir.mkdir('C:\\prjsync\\testA\\testB\\') unless Dir.exists? 'C:\\prjsync\\testA\\testB'
      File.open('C:\\prjsync\\testA\\myfile.csproj', 'w') { |f| f.puts 'Some file' }
    end

    it "find file" do
      finder = PrjfileFinder.new
      found = finder.find_from 'C:\\prjsync\\testA\\testB\\fakefile.cs'
      found.should == 'C:\\prjsync\\testA\\myfile.csproj'
    end
  end 
end
