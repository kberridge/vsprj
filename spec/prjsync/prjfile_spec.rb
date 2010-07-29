require 'spec_helper'
require 'tmpdir'

module Prjsync
  describe Prjfile do
    str = <<eos
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="3.5" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <ItemGroup>
    <Compile Include="Folder\\Path\\File.cs" />
    <Compile Include="Folder\\Other.js" />
    <Compile Include="More\\Tests.png" />
    <Compile Include="Hot\\Dogs.dll" />
  </ItemGroup>
</Project>
eos

    before :all do
      # write str to file
      @file = Dir.tmpdir + File::SEPARATOR + "in.xml"
      File.open( @file, 'w' ) { |f| f.write( str ) }
    end

    describe "extract" do
      it "extracts all included files" do
        files = []
        extractor = Prjsync::Prjfile.new( File.open( @file, 'r' ) )
        extractor.extract do |f| 
          files << f
        end

        files.should == [ 'Folder\Path\File.cs', 'Folder\Other.js', 
          'More\Tests.png', 'Hot\Dogs.dll' ]
      end
    end

    describe "add" do
      it "adds the file to the project file" do
        extractor = Prjsync::Prjfile.new( @file )
        extractor.add( 'Test\Add\File.cs' )
        # how do I test that it added?
        extractor.save

        doc = Nokogiri::XML( @file )
        val = doc.xpath('//xmlns:Compile/@Include["Test\Add\File.cs"]')
        val.should != nil
      end
    end

    describe "remove" do
      it "removes the file from the project file" do
        extractor = Prjsync::Prjfile.new( @file )
        extractor.remove( 'Hot\dog.dll' )
        # how do I test that it removed?
      end
    end
  end
end
