require 'spec_helper'
require 'fileutils'
describe 'basic operation' do
  before :each do
    FileUtils.rm_rf 'spec/tmp'
    FileUtils.cp_r 'spec/input', 'spec/tmp'
    @some_extant_file = 'spec/tmp/foo.conf.erb'
    @some_other_file = 'spec/tmp/foo.conf2.erb'
    @some_new_file = @some_extant_file + '2'
  end

  def diffycp from, to
    if block_given?
      input = "echo #{yield} |"
    end
    `#{input} bin/diffycp #{from} #{to}`
  end

  def files_should_be_same a, b
    File.read(a).should == File.read(b)
  end

  def files_should_differ a, b
    File.read(a).should_not == File.read(b)
  end

  it 'should copy cleanly when no destination' do
    output = diffycp @some_extant_file, @some_new_file
    files_should_be_same @some_extant_file, @some_new_file
    output.should == ''
  end

  it 'should speak up when there is no diff' do
    FileUtils.cp @some_extant_file, @some_new_file
    output = diffycp @some_extant_file, @some_new_file
    output.should match /are the same/
  end

  it 'should prompt when there is a diff, and not overwrite if "n"d' do
    FileUtils.cp @some_extant_file, @some_new_file
    File.open @some_extant_file, 'a' do |f| f.puts 'anotherline' end
    output = diffycp @some_extant_file, @some_new_file do 'n' end
    output.should match /anotherline/
    files_should_differ @some_extant_file, @some_new_file
    output.should match /OK. Leaving it alone./
  end

  it 'should prompt when there is a diff, and overwrite if "y"d' do
    File.read(@some_extant_file).should_not == File.read(@some_other_file)
    output = diffycp @some_extant_file, @some_new_file do 'y' end
    files_should_be_same @some_extant_file, @some_new_file
  end
end
