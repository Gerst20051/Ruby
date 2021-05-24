# Bundle Gem Setup Process

[$]> `bundle gem httpartyapp`

Creating gem 'httpartyapp'...
Do you want to generate tests with your gem?
Future `bundle gem` calls will use your choice. This setting can be changed anytime with `bundle config gem.test`.
Enter a test framework. rspec/minitest/test-unit/(none): `rspec`

Do you want to set up continuous integration for your gem? Supported services:
* CircleCI:       https://circleci.com/
* GitHub Actions: https://github.com/features/actions
* GitLab CI:      https://docs.gitlab.com/ee/ci/
* Travis CI:      https://travis-ci.org/

Future `bundle gem` calls will use your choice. This setting can be changed anytime with `bundle config gem.ci`.
Enter a CI service. github/travis/gitlab/circle/(none): `none`

Do you want to license your code permissively under the MIT license?
This means that any other developer or company will be legally allowed to use your code for free as long as they admit you created it. You can read more about the MIT license at https://choosealicense.com/licenses/mit. y/(n): `n`

Do you want to include a code of conduct in gems you generate?
Codes of conduct can increase contributions to your project by contributors who prefer collaborative, safe spaces. You can read more about the code of conduct at contributor-covenant.org. Having a code of conduct means agreeing to the responsibility of enforcing it, so be sure that you are prepared to do that. Be sure that your email address is specified as a contact in the generated code of conduct so that people know who to contact in case of a violation. For suggestions about how to enforce codes of conduct, see https://bit.ly/coc-enforcement. y/(n): `n`

Do you want to include a changelog?
A changelog is a file which contains a curated, chronologically ordered list of notable changes for each version of a project. To make it easier for users and contributors to see precisely what notable changes have been made between each release (or version) of the project. Whether consumers or developers, the end users of software are human beings who care about what's in the software. When the software changes, people want to know why and how. see https://keepachangelog.com y/(n): `y`
Changelog enabled in config

Do you want to add rubocop as a dependency for gems you generate?
RuboCop is a static code analyzer that has out-of-the-box rules for many of the guidelines in the community style guide. For more information, see the RuboCop docs (https://docs.rubocop.org/en/stable/) and the Ruby Style Guides (https://github.com/rubocop-hq/ruby-style-guide). y/(n): `y`

Initializing git repo in httpartyapp

    create  httpartyapp/Gemfile
    create  httpartyapp/lib/httpartyapp.rb
    create  httpartyapp/lib/httpartyapp/version.rb
    create  httpartyapp/httpartyapp.gemspec
    create  httpartyapp/Rakefile
    create  httpartyapp/README.md
    create  httpartyapp/bin/console
    create  httpartyapp/bin/setup
    create  httpartyapp/.gitignore
    create  httpartyapp/.rspec
    create  httpartyapp/spec/spec_helper.rb
    create  httpartyapp/spec/httpartyapp_spec.rb
    create  httpartyapp/CHANGELOG.md
    create  httpartyapp/.rubocop.yml

Gem 'httpartyapp' was successfully created. For more information on making a RubyGem visit https://bundler.io/guides/creating_gem.html

Remove Git Directory If Inside Another Repository

[$]> `rm -rf httpartyapp/.git`
