class CategoryList
    attr_accessor :categories, :cat_choice              

    def initialize
        @categories = ['business', 'science', 'tech', 'culture', 'security', 'transportation']
        #descriptions = [..., ...]
    end 

    def list
        count = 1
        @categories.each do |cat| 
            puts "#{count}) #{cat.capitalize}"    #add desc. here 
            count += 1
        end 
    end 

end 

