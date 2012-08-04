source :rubygems

group :test do
  %w(pry rspec oj).map do |e| gem e end
  gem 'simplecov', require: false
  gem 'guard', git: 'https://github.com/guard/guard.git'
  gem 'guard-rspec', git: 'https://github.com/guard/guard-rspec.git'
end
