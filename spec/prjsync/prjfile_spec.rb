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
      file = Dir.tmpdir + File::SEPARATOR + "in.xml"
      File.open( file, 'w' ) { |f| f.write( str ) }
      @prjFile = Prjsync::Prjfile.new( File.open( file, 'r' ) )
    end

    describe "extract" do
      it "extracts all included files" do
        files = []
        @prjFile.extract do |f| 
          files << f
        end

        files.should == [ 'Folder\Path\File.cs', 'Folder\Other.js', 
          'More\Tests.png', 'Hot\Dogs.dll' ]
      end
    end

    describe "add" do
      it "adds the file to the project file" do
        testFile = 'Test\Add\File.cs'
        @prjFile.add( testFile )
        
        doc = Nokogiri::XML( @prjFile.text )
        val = doc.xpath("//xmlns:Compile[@Include = \"#{testFile}\"]")
        val.should_not be_nil
      end
    end

    describe "remove" do
      it "removes the file from the project file" do
        testFile = "Hot\\Dogs.dll"
        @prjFile.remove( testFile )

        doc = Nokogiri::XML( @prjFile.text )
        val = doc.xpath( "//xmlns:Compile[@Include = \"#{testFile}\"]")
        val.length.should == 0
      end
    end
  end
end
