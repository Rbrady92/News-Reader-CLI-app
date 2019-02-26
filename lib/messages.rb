class Messages    
    
    def welcome 
        puts "Welcome! This gem aggregates articles from the popular tech news sites Wired, Mashable, and The Verge."
    end 

    def space 
        puts ""
    end 

    def elem(el)
        puts "#{el}"
    end 

    def readable(text)
        text.each {|el| puts "#{el}"}
    end 

    def list(titles)
        count = 1

        titles.each do |title| 
            puts "#{count}) #{title}"
            space 
            count += 1
        end 
    end 

    def cat_select
        puts "Select the genre you'd like to browse by entering the corresponding number."
    end 

    def invalid_input
        puts "The input you entered appears to be invalid."
    end 

    def art_select
        puts "If you see an article you'd like to read, enter the corresponding number to view it."
    end 

    def return_to_menu 
        puts "If you'd like to return to the main menu, enter 'menu' without the quotes."
    end 

    def url_message(el)
        puts "Here is a link you can copy/paste if you'd like to share this article or read it in your browser: #{el}"
    end 

    def exit_prompt
        puts "To exit the program at any time, enter 'exit' without the quotes."
    end 

    def exit_message
        "Thanks for using Tech News Reader!"
    end 

end