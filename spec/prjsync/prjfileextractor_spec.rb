require 'spec_helper'

module Prjsync
  describe Prjfileextractor do
    describe "extract" do
      it "extracts all included files" do
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

        files = []
        extractor = Prjsync::Prjfileextractor.new()
        extractor.extract str do |f| 
          files << f
        end

        files.should == [ 'Folder\Path\File.cs', 'Folder\Other.js', 
          'More\Tests.png', 'Hot\Dogs.dll' ]
      end
    end
  end
end
