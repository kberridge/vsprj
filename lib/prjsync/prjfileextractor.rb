require 'rubygems'
require 'nokogiri'

module Prjsync
  class Prjfileextractor
    def extract xml
      doc = Nokogiri::XML( xml )
      doc.xpath("//xmlns:Compile/@Include").each do |f|
        yield f.value
      end
    end
  end
end
