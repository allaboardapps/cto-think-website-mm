require "tzinfo"
Time.zone = "America/New_York"

# redirect "/rss2.xml", to: "/rss.xml"

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# Global Variables
set :site_description, "A pragmatic podcast about leadership, product dev, and tech decisions between two recovering Chief Technology Officers."
set :site_keywords, "chief technology officer, business, management, technology, leadership, development, Don VanDemark, Randy Burgess"
set :site_name, "CTO Think"
set :author, "CTO Think"
set :site_acronym, "CTO"
set :site_email, "hello@ctothink.com"
set :site_url, "https://www.ctothink.com"
set :cdn_url, "https://s3.amazonaws.com/cto-think-podcast-assets"
set :site_copyright, "© 2017-2018 CTO Think. All Rights Reserved."
set :genre, "http://vocab.getty.edu/aat/300056069"
set :image_url, "https://s3.amazonaws.com/cto-think-podcast-assets/cto-think-logo-itunes.jpg"
set :twitter_handle, "@ctothink"
set :ga_id, "UA-111873195-1"
set :bing_validation, "332ADCC9E2D993407E5001016E4C23CC"
set :yandex_validation, "20d748a5f7352073"


activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :blog do |blog|
  blog.sources = "episodes/{year}-{month}-{day}-{id}.html"
  blog.permalink = "episodes/{year}-{month}-{day}-{id}.html"
  blog.layout = "episodes"
  blog.summary_separator = /READMORE/
end

activate :asset_hash
activate :livereload
activate :gzip
activate :sprockets

if defined? RailsAssets
  RailsAssets.load_paths.each do |path|
    sprockets.append_path path
  end
end

set(:port, 3000)

helpers do
  def cdn_file_url(file_name)
    "#{config[:cdn_url]}/#{file_name}"
  end

  def image_url(file_name)
    "#{config[:site_url]}/images/#{file_name}"
  end
end

