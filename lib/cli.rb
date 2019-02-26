require 'site_list'
require 'scraper'
require 'categories'
require 'messages'

class CLI
    attr_accessor :cat_choice, :art_choice, :site_list, :categories, :scraper, :messages

    def initialize
        @categories = CategoryList.new 
        @messages = Messages.new
        @site_list = SiteList.new
        @scraper = Scraper.new
    end 

    def start  
        @messages.space
        @messages.welcome

        menu
        cat_choice         
        pass_cat
        scrape_titles        
        list_titles
        art_choice

        #check

        display_text
        close

    end 

    # def check
    #     @scraper.url_scrape

    #     count = 0
        
    #     @scraper.titles.each do |art|
    #         puts "#{art}"
    #         puts "#{@scraper.urls[count]}"
    #         puts ""
    #         count +=1
    #     end 
    #     @scraper.titles.clear
    #     @scraper.urls.clear
    # end 

    def menu
        @messages.space
        @messages.cat_select
        @messages.exit_prompt
        @messages.space
        @categories.list         
        @messages.space
    end 

    def cat_choice                                
        @cat_choice = gets.strip

        if @cat_choice == 'exit'
            exit 
        end 

        @cat_choice = @cat_choice.to_i                  #could manually account for input of 'one, two, etc' instead of relying on to_i                                            

        if @cat_choice > 0 && @cat_choice < 7 
            @cat_choice -= 1
            cat_num = @cat_choice
            @cat_choice = @categories.categories[cat_num]    
            @categories.cat_choice = @cat_choice     
            @messages.elem(@categories.cat_choice)
            #puts @categories.cat_choice
            @site_list.cat_control
        else 
            @messages.invalid_input
            start
        end 
    end 


    def pass_cat
        #@site_list = SiteList.new(@cat_choice)  
        @site_list.category = @cat_choice  
        @site_list.create_urls    
        @site_list.cat_control                                     
    end 

    def scrape_titles
        #@scraper = Scraper.new       
        @scraper.sites = @site_list    
        @scraper.cat_choice = @cat_choice                
    end                              

    def list_titles             
        @scraper.title_scrape       

        2.times {@messages.space}
        @messages.art_select
        @messages.space
        @messages.return_to_menu
        2.times {@messages.space}

        @messages.list(@scraper.titles)

        #count = 1
        # @scraper.titles.each do |title|      
        #     puts "#{count}) #{title}"       
        #     @messages.space
        #     count += 1     
        # end         
    end 

    def art_choice
        @art_choice = gets.strip

        if @art_choice == 'menu'
            @scraper.titles.clear
            @scraper.urls.clear
            start
        else 
            @art_choice = @art_choice.to_i                                                    

            if @art_choice > 0 && @art_choice <= @scraper.titles.length 
                @art_choice -= 1    
                @scraper.url_scrape                              
                @scraper.art_choice = @art_choice                                          
            else 
                @messages.invalid_input
                art_choice
            end 
        end
    end 

    def display_text                               #extract to messages maybe
        2.times {@messages.space}
        #puts "#{@scraper.titles[@art_choice]}"   
        @messages.elem(@scraper.titles[@art_choice])     
        @messages.space
        @messages.url_message(@scraper.urls[@art_choice])
        3.times {@messages.space} 

        @scraper.text_scrape

        @messages.readable(@scraper.text)
        #puts @scraper.text
    end 

    def close
        3.times {@messages.space} 
        @messages.return_to_menu
        @messages.exit_prompt
        @messages.space

        art_end = gets.strip

        if art_end == 'menu' 
            @scraper.titles.clear
            @scraper.urls.clear
            @scraper.text.clear
            start
        elsif art_end == 'exit'
            @messages.space
            @messages.exit_message    
            exit                 
        else 
            @messages.invalid_input
            close
        end 
    end 

end 


#should maybe add class that creates all new class objects instead of doing here

#need to clear title/url arrays after article text is displayed. going back to menu and selecting new cat. displays info from previous scrapes

#could display only limited # of titles at a time, science/tech/culture have a lot of articles