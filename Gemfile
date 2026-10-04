source "https://rubygems.org"

# GitHub Pages builds this site server-side with its own gem set, so this
# Gemfile only governs local preview. The `github-pages` gem is pinned to an
# old Jekyll whose commonmarker dependency caps Ruby at < 4.0, so it cannot
# install on current Ruby. Plain Jekyll 4 renders this site identically:
# there are no plugins, no Sass, and markdown is kramdown.
gem "jekyll", "~> 4.4"
gem "webrick"
