class Wordhunt::Scraper

# title scrape
	def self.scrape_titles_and_links(index_url)
	    doc = Nokogiri::HTML(open(index_url))

# build hash for each title with a link to more info, compile hashes into array
    	hash_array = []
    	doc.css(".item-ia[data-mediatype='texts']").each do |item|
      		hash_array << { 
        		:title => item.css(".item-ttl a").attribute("title").value,
        		:info_url => item.css(".item-ttl a").attribute("href").value
      		}
    	end 
# append full prefix to partial URLs
    	hash_array.each { |h| 
    	  h[:info_url].insert(0, 'http://www.archive.org') 
    	}     
# call next scraper method to find url of complete text
   		hash_array.each { |h|
    	  h[:text_url] = self.get_url_of_complete_text(h[:info_url])
    	}

      hash_array.delete_if { |h| h[:text_url] == nil }

      hash_array.each do |h|
            doc = Nokogiri::HTML(open(h[:text_url])).text
            # make it pretty
            doc.gsub!("\r", " ")
            doc.gsub!("\n", " ")
            # doc.gsub!("\\", "")
            h[:fulltext] = doc
        end     
# make books
    	Wordhunt::Book.make_books(hash_array)
  	end
    
#  scrape text detail (link to full text)
	def self.get_url_of_complete_text(info_url)
    	doc = Nokogiri::HTML(open(info_url))
  
  # returns array of all links to complete texts (includes epub, jpeg, etc.)
    	array = doc.css(".stealth.download-pill").collect { |n| 
    	  n.attribute("href").value }

  # reduces array to only the links that are plaintext
    	array.select! {  |n| n.include?("TEXT") || n.include?("txt")}

  # appends full prefix to partial urls
    	array.each { |link| link.insert(0, 'http://www.archive.org')}

  # returns only first item of array (others are duplicates)
    	array.shift
  	end
end
