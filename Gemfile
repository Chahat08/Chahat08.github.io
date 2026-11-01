source "https://rubygems.org"

# The live site is built by .github/workflows/pages.yml with this exact gem
# set, so local preview and production match. (The classic `github-pages`
# build can't be used: it pins an old Jekyll that caps Ruby at < 4.0 and it
# blocks the custom plugin in _plugins/.)
gem "jekyll", "~> 4.4"
gem "webrick"

group :jekyll_plugins do
  gem "jekyll-redirect-from"
end
