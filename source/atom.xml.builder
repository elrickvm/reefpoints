xml.instruct!
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  site_url = 'http://reefpoints.dockyard.com'
  xml.title 'DockYard - Reefpoints'
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, current_page.path), 'rel' => 'self'
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name 'DockYard' }

  blog.articles.each do |article|
    xml.entry do
      xml.title article.title
      xml.link 'rel' => 'alternate', 'href' => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name article.author }
      xml.summary article.summary
      xml.content article.body, 'type' => 'html'
    end
  end
end
