class Scraper 

    @@cat_choice = ''
    @@art_num = ''
    
    def self.cat_choice(cat) 
        @@cat_choice = cat
    end 

    def self.set_art_num(num)
        @@art_num = num
    end 

    def self.art_num 
        @@art_num 
    end 

    def self.title_and_url_scrape
        wired_url = "https://www.wired.com/category/#{@@cat_choice}/"

        Nokogiri::HTML(open(wired_url)).css('[to*=story] h2').each {|title| Articles.titles << title.text}

        Nokogiri::HTML(open(wired_url)).css('[class*=card-component__description] [to*=story]').each {|url| Articles.urls << 'https://www.wired.com' + url.attr('href')}
    
        Articles.format_urls
    end 

    def self.text_scrape
        article = Nokogiri::HTML(open(Articles.urls[@@art_num]))          

        article.css('.article-body-component p').each do |curr|
            Articles.text << curr.text
            Articles.text << ""
        end 
    end 

    def self.author_and_date 
        article = Nokogiri::HTML(open(Articles.urls[@@art_num]))

        author = article.css('.meta-list .visually-hidden').text       
        Articles.set_author(author)
        Articles.format_author
        
        date = article.css('time').text.slice(0, 16)
        Articles.set_date(date)
        Articles.format_date        
    end 

end 
