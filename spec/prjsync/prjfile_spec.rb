require 'spec_helper'

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

    describe "extract" do
      it "extracts all included files" do
        files = []
        extractor = Prjsync::Prjfile.new( str )
        extractor.extract do |f| 
          files << f
        end

        files.should == [ 'Folder\Path\File.cs', 'Folder\Other.js', 
          'More\Tests.png', 'Hot\Dogs.dll' ]
      end
    end

    describe "add" do
      it "adds the file to the project file" do
        extractor = Prjsync::Prjfile.new( str )
        extractor.add( 'Test\Add\File.cs' )
        # how do I test that it added?
      end
    end

    describe "remove" do
      it "removes the file from the project file" do
        extractor = Prjsync::Prjfile.new( str )
        extractor.remove( 'Hot\dog.dll' )
        # how do I test that it removed?
      end
    end
  end
end
