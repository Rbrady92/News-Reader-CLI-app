class CLI 
    #attr_accessor :scraper, :articles

    @@categories = ['business', 'culture', 'gear', 'ideas', 'science', 'security', 'transportation']         

    # def initialize
    #     @scraper = Scraper.new 
    #     @articles = Articles.new 
    # end 

    def self.categories 
        @@categories 
    end 


    def self.start 
        2.times {puts ""}
        puts "Welcome! This gem aggregates articles from the popular tech news site 'Wired'."
        puts ""
        puts "Select the genre you'd like to browse by entering the corresponding number."
        puts ""
        puts "To exit the program at any time, enter 'exit' without the quotes."
        2.times {puts ""}

        list_cats        
        choose_cat 
        Scraper.title_and_url_scrape
        list_titles
        art_choice 
        Scraper.text_scrape
        Scraper.author_and_date
        display_text
        end_of_art
    end 


    def self.list_cats
        count = 1

        @@categories.each do |cat|                          
            puts "#{count}) #{cat.capitalize}"    
            count += 1
        end 
    end 

    
    def self.choose_cat 
        puts ""

        cat_num = gets.strip 

        if cat_num == 'exit'
            exit 
        end 

        cat_num = cat_num.to_i

        if cat_num > 0 && cat_num < 8 
            cat_num -= 1 
            cat_choice = @@categories[cat_num]
            Scraper.cat_choice(cat_choice)        

            #Scraper.articles = @articles                       
        end 
    end 


    def self.list_titles
        3.times {puts ""}
        puts "If you see an article you'd like to read, enter the corresponding number to view it."
        3.times {puts ""}

        count = 1

        Articles.titles.each do |title|
            puts "#{count}) #{title}"
            puts ""
            count += 1
        end 

        puts "#{Articles.urls}"
    end 


    def self.art_choice 
        art_num = gets.strip 

        if art_num == 'menu'
            Articles.titles.clear 
            Articles.urls.clear
            start
        elsif art_num == 'exit'
            exit 
        end 

        art_num = art_num.to_i 

        if art_num > 0 && art_num <= Articles.titles.length
            art_num -= 1
            Scraper.set_art_num(art_num)
        else 
            puts "The input you entered appears to be invalid, please enter a number corresponding to an article."
        end 
    end 


    def self.display_text
        3.times {puts ""}
        puts "#{Articles.titles[Scraper.art_num]}"
        puts ""
        puts "Author:#{Articles.author[1]}"
        puts "Date Posted: #{Articles.date_posted} EST"
        puts ""
        puts "Link: #{Articles.urls[Scraper.art_num]}"
        3.times {puts ""}

        Articles.text.each {|paragraph| puts "#{paragraph}"} 
    end 


    def self.end_of_art 
        3.times {puts ""}
        puts "If you'd like to return to the main menu, enter 'menu'. To exit the program, enter 'exit'."
        puts ""

        art_end = gets.strip 

        if art_end == 'menu'
            Articles.titles.clear 
            Articles.urls.clear
            Articles.text.clear
            start
        elsif art_end == 'exit'
            2.times {puts""}
            puts "Thanks for using News-Reader!"
            exit 
        else 
            puts "The input you entered appears to be invalid."
            puts "If you'd like to return to the main menu, enter 'menu'. To exit the program, enter 'exit.'"
        end 
    end 

end 



#could do most, if not all of the article stuff in realtime/in scraper as a return value instead of storing it and then querying
#the storage class

#check notes at bottom of cli class in original news-reader folder