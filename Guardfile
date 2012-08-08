# More info at https://github.com/guard/guard#readme
guard 'rspec', :version => 2 do
  watch 'bin/...erb' do 'spec/dotdotdoterb_spec.rb' end
  watch 'bin/erbuild' do 'spec/erbuild_spec.rb' end
  watch 'bin/diffycp' do 'spec/diffycp_spec.rb' end
  watch %r{^spec/.+_spec\.rb}
  watch 'spec/spec_helper.rb'
end

# vim:ft=ruby
