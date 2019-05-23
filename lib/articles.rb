class Articles 

    @@titles = []
    @@urls = []
    @@text = []
    @@author = ''
    @@date_posted = ''

    def self.titles
        @@titles
    end 
    
    def self.urls
       @@urls
    end 

    def self.text
        @@text 
    end 

    def self.author
        @@author 
    end 
    
    def self.date_posted
        @@date_posted 
    end 

    def self.set_date(date)
        @@date_posted = date
    end 

    def self.set_author(author)
        @@author = author
    end 

    def self.format_urls 
        @@urls.uniq!
    end 

    def self.format_author
        @@author = @@author.split("Author:")
    end 

    def self.format_date
        @@date_posted.insert(8, " ")
    end 

end 
