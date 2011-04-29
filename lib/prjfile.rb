require 'rubygems'
require 'nokogiri'

class Prjfile
  def initialize xml
    @doc = Nokogiri::XML(xml)
  end

  def extract
    @doc.xpath('//xmlns:Compile/@Include').each do |f|
      yield f.value
    end
  end

  def add file
    return if contains? file

    ig = @doc.xpath('//xmlns:ItemGroup')[0]
    compile = Nokogiri::XML::Node.new('Compile', @doc)
    compile['Include'] = file
    ig.add_child(compile)
  end

  def text
    @doc.to_xml
  end

  def remove file
    xp = "//xmlns:Compile[@Include = \"#{file}\"]"
    n = @doc.xpath(xp)
    n.remove
  end

  def contains? file
    xp = "//xmlns:Compile[@Include = \"#{file}\"]"
    n = @doc.xpath(xp)
    !n.empty?
  end
end
