# Setup Steps

[$]> `bundle init`

[$]> `echo '2.7.2' > .ruby-version`

Could Also Use RVM To Generate The Ruby Version File

[$]> `rvm --ruby-version use 2.7.2`

[$]> `rvm use`

Specify Ruby Version `ruby "2.7.2"` In The `Gemfile`

[$]> `bundle add httparty`

[$]> `bundle install`

[$]> `touch app.rb`

[$]> `mkdir lib spec`

# Running Commands

[$]> `ruby app.rb` or `./app.rb`

[$]> `irb -r ./lib/ip_grabber`

...> `ip = IPGrabber.new`

...> `ip.get`

...> `exit`

# Testing

Could use `RSpec` https://rspec.info
Could use `Minitest` http://docs.seattlerb.org/minitest/
Could use `Test Unit` https://test-unit.github.io/
