require 'spec_helper'
describe 'basic operation' do
  before :each do
    FileUtils.rm_rf 'spec/tmp'
    FileUtils.cp_r 'spec/input', 'spec/tmp'
  end

  def run_for file_name
    out = 'spec/tmp/' + file_name
    expected = 'spec/expected/' + file_name
    File.exist?(out).should be_false
    cmd = 'bin/erbit ' + out
    system(cmd) or fail "\`#{cmd}\` failed."
    actual_data = File.read(out)
    if ENV['snapshot']
      puts "Snapshotting #{expected}"
      File.open(expected, 'w').write(actual_data)
    else
      actual_data.should == File.read(expected)
    end
  end

  it 'should work with .yml' do run_for 'foo.conf' end
  it 'should work without .yml' do run_for 'noyaml.conf' end

  # TODO better output on ERb parse failure. Make it look like erbit knows
  # what happened rather than got lambasted (or errored itself)
end
