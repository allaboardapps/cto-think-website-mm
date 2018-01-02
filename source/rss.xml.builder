require "securerandom"

xml.feed(
  "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/",
  "xmlns:admin" => "http://webns.net/mvcb/",
  "xmlns:rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:googleplay" => "http://www.google.com/schemas/play-podcasts/1.0",
  "version" => "2.0",
  "xmlns:atom" => "http://www.w3.org/2005/Atom",
  "encoding" => "UTF-8"
) do
  xml.channel do
    xml.title "CTO Think"
    xml.description "A podcast about how CTOs think about technology and business problems"
    xml.link "href" => "https://www.ctothink.com/feed.xml", "rel" => "self"
    xml.updated blog.articles.last.date.to_time.iso8601
    xml.author do
      xml.name "Don VanDemark and Randy Burgess"
    end
    xml.language "en-us"
    xml.copyright "Copyright 2017-2018 CTO Think. All Rights Reserved."
    xml.lastBuildDate blog.articles.first.date.to_time.iso8601
    xml.atom :linkhref, "https://www.ctothink.com/feed.xml"
    xml.itunes :author, "Don VanDemark and Randy Burgess"
    xml.itunes :subtitle, "CTO Think podcast subtitle"
    xml.itunes :summary, "CTO Think podcast summary"
    xml.itunes :type, "episodic"
    xml.itunes :image, href: image_url("cto_think_logo.jpg")
    xml.itunes :owner do
      xml.itunes :name, "Don VanDemark and Randy Burgess"
      xml.itunes :email, "advice@ctothink.com"
    end
    xml.itunes :category, text: "Technology" do
      xml.itunes :category, text: "Tech News"
    end
    xml.itunes :category, text: "Business" do
      xml.itunes :category, text: "Management & Marketing"
    end
    xml.itunes :category, text: "Education" do
      xml.itunes :category, text: "Training"
    end
    xml.itunes :explicit, "no"

    blog.articles.each do |article|
      if article.data.published
        xml.item do
          xml.title article.title
          xml.author "Don VanDemark and Randy Burgess"
          xml.id article.data.id
          xml.published article.date.to_time.iso8601
          xml.pubDate article.date.to_time.iso8601
          xml.updated article.date.to_time.iso8601
          xml.itunes :duration, text: article.data.duration
          xml.itunes :episodeType, "full"
          xml.description do
            xml.cdata! article.body
          end
          xml.enclosure url: podcast_file_url(article.data.audio_file_name), length: "37934213", type: "audio/mp3"
          xml.link podcast_file_url(article.data.audio_file_name)
          xml.guid({ isPermaLink: false }, SecureRandom.uuid)
        end
      end
    end
  end
end