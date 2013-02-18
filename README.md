# RSpec Org Formatter

An [RSpec][rspec] formatter that outputs results meant to be viewed with [emacs][emacs] in an [Org mode][orgmode] buffer. 

## Usage

Install the gem:

    gem install rspec_org_formatter

Use it:

    rspec -f RspecOrgFormatter --out rspec.org

You'll get an org file with your results in it.

## More Permanent Usage

Add it to your Gemfile if you're using [Bundler][bundler].

In your .rspec, usually alongside another formatter, add:

    -f RspecOrgFormatter
    --out rspec.org


## License

The MIT License, see [LICENSE][license].

  [rspec]: http://rspec.info/
  [bundler]: http://gembundler.com/
  [license]: https://github.com/sj26/rspec-junit-formatter/blob/master/LICENSE
  [orgmode]: http://orgmode.org/
  [emacs]: http://www.gnu.org/software/emacs/
