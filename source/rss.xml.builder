xml.instruct!
xml.rss(
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/",
  "xmlns:admin" => "http://webns.net/mvcb/",
  "xmlns:atom" => "http://www.w3.org/2005/Atom",
  "xmlns:rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",
  "xmlns:googleplay" => "http://www.google.com/schemas/play-podcasts/1.0",
  "version" => "2.0"
) do
  xml.channel do
    xml.title config[:site_name]
    xml.link config[:site_url]
    xml.pubDate blog.articles.first.date.strftime("%a, %e %b %Y %k:%M:%S %Z")
    xml.description config[:site_description]
    xml.language "en-us"
    xml.copyright config[:site_copyright]
    xml.itunes :subtitle, config[:site_name]
    xml.itunes :author, config[:site_name]
    xml.itunes :summary, config[:site_description]
    xml.itunes :image, href: "#{config[:cdn_url]}/cto-think-logo-itunes.jpg"
    xml.itunes :keywords, "technology, business, leadership, management, cto, executive, Don VanDemark, Randy Burgess"
    xml.itunes :explicit, "no"
    xml.itunes :owner do
      xml.itunes :name, config[:site_name]
      xml.itunes :email, config[:site_email]
    end
    xml.itunes :category, text: "Technology"
    xml.itunes :category, text: "Business" do
      xml.itunes :category, text: "Management & Marketing"
    end
    xml.itunes :category, text: "Business" do
      xml.itunes :category, text: "Careers"
    end
    xml.itunes :type, "episodic"
    blog.articles.each_with_index do |article, index|
      if article.data.published
        order_number = index + 1

        xml.item do
          xml.tag! "atom:link", href: "https://www.ctothink.com/rss.xml", rel: "self", type: "application/atom+xml", title: "MP3 Audio"
          xml.id article.data.id
          xml.title "#{article.data.id}: #{article.title}"
          xml.link "#{config[:site_url]}#{article.url}"
          xml.guid({ isPermaLink: false }, "#{config[:cdn_url]}/#{article.data.audio_file_name}")
          xml.pubDate article.date.strftime("%a, %e %b %Y %k:%M:%S %Z")
          xml.lastBuildDate article.date.strftime("%a, %e %b %Y %k:%M:%S %Z")
          xml.author config[:site_name]
          xml.description do
            xml.cdata! article.body
          end
          xml.enclosure url: article.data.soundcloud_link, length: article.data.file_size_bytes, type: article.data.file_type
          xml.content :encoded do
            xml.cdata! article.body
          end
          xml.itunes :order, order_number
          xml.itunes :author, config[:site_name]
          xml.itunes :duration, article.data.duration
          xml.itunes :subtitle do
            xml.cdata! article.summary
          end
          xml.itunes :summary do
            xml.cdata! article.body
          end
          xml.itunes :keywords, article.data.keywords
          xml.itunes :image, href: "#{config[:cdn_url]}/cto-think-logo-itunes.jpg"
          xml.itunes :explicit, article.data.explicit
        end
      end
    end
  end
end
