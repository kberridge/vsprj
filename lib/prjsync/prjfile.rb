require 'rubygems'
require 'nokogiri'

module Prjsync
  class Prjfile
    def initialize xml
      @doc = Nokogiri::XML( xml )
    end
    def extract
      @doc.xpath("//xmlns:Compile/@Include").each do |f|
        yield f.value
      end
    end
  end
end
