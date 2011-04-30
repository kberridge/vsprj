require 'rspec'
require_relative '../lib/command_runner'

describe CommandRunner do
  before :each do
    @full_file_path = '/a/full/path/to/some/file/path/tofile.cs'
    @in_file_path = 'some/file/path/tofile.cs'
    @expected_rel_path = 'path\\tofile.cs'

    @finder = mock('finder')
    @finder.stub!(:find_from).
      and_return('/a/full/path/to/some/file/prjfile.csproj')
    PrjfileFinder.stub!(:new).and_return(@finder)

    @prjfile = mock('prjfile')
    Prjfile.stub!(:new).and_return(@prjfile)

    File.stub!(:open)
    File.stub!(:expand_path).and_return(@full_file_path)
  end

  it "adds file on add" do 
    @prjfile.should_receive(:add).with(@expected_rel_path)
    subject.run ['add', @in_file_path]
  end

  it "removes file on remove" do
    @prjfile.should_receive(:remove).with(@expected_rel_path)
    subject.run ['remove', @in_file_path]
  end
end
