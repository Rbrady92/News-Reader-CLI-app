class SiteList
    attr_accessor :category, :wired, :verge, :mashable

    # def initialize#(category)
    #     #@category = category
    #     @wired = "https://www.wired.com/category/#{@category}/"
    #     @verge = ["https://www.theverge.com/#{@category}"]
    #     @mashable = ["https://mashable.com/#{@category}/?utm_cid=mash-prod-nav-ch"]
    #     #cat_control
    # end 

    def create_urls
        @wired = "https://www.wired.com/category/#{@category}/"
        @verge = ["https://www.theverge.com/#{@category}"]
        @mashable = ["https://mashable.com/#{@category}/?utm_cid=mash-prod-nav-ch"]
    end 

    def cat_control
        if @category == 'tech'
            @wired = "https://www.wired.com/category/gear/"

        elsif category == 'culture'
            @mashable << "https://mashable.com/entertainment/?utm_cid=mash-prod-nav-ch"
        end 
    end 
end 




