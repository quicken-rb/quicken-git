# Quicken::Git

Quicken plugin to initialize Git repositories

## Installation


    $ gem install quicken-git

## Usage

In your `recipe.yml`, add:

```yaml
# Initialize a repo in the current dir

- git: true

```

```yaml
# Initialize a repo in a specific dir

- git: /path/to/dir

```

```yaml
# Initialize a repo with a more complex configuration

- git:
    path: /path/to/dir                      # default to current dir
    remote: https://example.com/repo.git    # add the remote as origin
    # or 
    remote:                                 # add many remotes
        origin: https://example.com/repo.git
        test:   https://example.com/repo.git

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quicken-git. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Quicken::Git project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/quicken-git/blob/master/CODE_OF_CONDUCT.md).
