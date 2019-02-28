require 'nokogiri'
require 'open-uri'

class Scraper
    attr_accessor :titles, :urls, :text, :sites, :art_choice, :cat_choice        

    def initialize
        @titles = []
        @urls = []
        @text = []
    end 

    def title_scrape
        if @cat_choice == 'business' || @cat_choice == 'security' || @cat_choice == 'transportation'
            Nokogiri::HTML(open(@sites.wired)).css('a h2').each {|title| @titles << title.text}  

        else 
            Nokogiri::HTML(open(@sites.wired)).css('[to*=story] h2').each {|title| @titles << title.text}  

            @sites.mashable.each {|site| Nokogiri::HTML(open(site)).css('#column-new .column-content .flat h1').each {|title| @titles << title.css('a').text unless title.css('a').attr('href').text.include?('video')}}
        
            @sites.verge.each {|site| Nokogiri::HTML(open(site)).css('.c-entry-box--compact--article [data-analytics-link=article]').each {|title| @titles << title.text unless title.text == "View All Stories"}} 
        end 

        #@titles.delete_if {|title| title == "View All Stories"}
    end 

    def url_scrape
        if @cat_choice == 'business' || @cat_choice == 'security' || @cat_choice == 'transportation'
            Nokogiri::HTML(open(@sites.wired)).css('[class*=card-component__description] [to*=story]').each {|url| @urls << 'https://www.wired.com' + url.attr('href')}
        
        else
            Nokogiri::HTML(open(@sites.wired)).css('[class*=card-component__description] [to*=story]').each {|url| @urls << 'https://www.wired.com' + url.attr('href')}

            @sites.mashable.each {|site| Nokogiri::HTML(open(site)).css('#column-new .column-content .flat h1').each {|url| @urls << "#{url.css('a').attr('href')}?utm_cid=hp-n-1" unless url.css('a').attr('href').text.include?('video')}} 

            @sites.verge.each {|site| Nokogiri::HTML(open(site)).css('.c-entry-box--compact--article [data-analytics-link=article]').each {|url| @urls << url.attr('href')}}
        end 

        @urls.uniq!         #uniq is needed because wired produces dupes
    end 

    def text_scrape
        article = Nokogiri::HTML(open(@urls[@art_choice]))

        if @urls[@art_choice].include?('wired.com')
            article.css('.article-body-component p').each do |curr|
                @text << curr.text
                @text << ""
            end 

        elsif @urls[@art_choice].include?('mashable.com')
            article.css('.article-content p').each do |curr|           #still need to figure out how to exclude image text/captions
                @text << curr.text unless curr.text.include?('SEE ALSO') 
                @text << ""
            end 
            @text.each do |curr| 
                curr.gsub!(/Â/, '')
                curr.gsub!(/"'"/, "'")
                #curr = curr.replaceAll("\\p{Pd}", "-")     #should replace any form of dash but isnt working
            end 

        elsif @urls[@art_choice].include?('theverge')
            article.css('.c-entry-content p').each do |curr| 
                @text << curr.text
                @text << ""
            end 
        end    
    end 

end 
