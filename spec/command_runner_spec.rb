require 'rspec'
require_relative '../lib/command_runner'

describe CommandRunner do
  before :each do
    @finder = mock('finder')
    @finder.stub!(:find_from).and_return('some/file/prjfile.csproj')
    PrjfileFinder.stub!(:new).and_return(@finder)

    @prjfile = mock('prjfile')
    Prjfile.stub!(:new).and_return(@prjfile)

    File.stub!(:open) #this is ugly...
  end

  it "adds file on add" do 
    @prjfile.should_receive(:add).with('some/file/path.cs')
    subject.run ["add", 'some/file/path.cs']
  end

  it "removes file on remove" do
    @prjfile.should_receive(:remove).with('some/file/path.cs')
    subject.run ["remove", "some/file/path.cs"]
  end
end
