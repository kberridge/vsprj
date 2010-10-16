require 'rubygems'
require 'nokogiri'

module Prjsync
  class Prjfile
    def initialize xml
      @doc = Nokogiri::XML( xml )
    end

    def extract
      @doc.xpath( '//xmlns:Compile/@Include' ).each do |f|
        yield f.value
      end
    end

    def add str
      ig = @doc.xpath( '//xmlns:ItemGroup' )[0]
      compile = Nokogiri::XML::Node.new('Compile', @doc)
      compile['Include'] = str
      ig.add_child( compile )
    end

    def text
      @doc.to_xml
    end
  end
end
