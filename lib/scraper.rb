require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    index_page_profiles = index_page.css("div.student-card")
    index_page_array = []
    index_page_profiles.each do |profile|
      index_page_array << {:name => "#{profile.css("h4").text}" , :location => "#{profile.css("p").text}" , :profile_url => "#{profile.css("a").attribute("href").text}"}
    end 
    index_page_array
  end
  
  

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    #binding.pry 
    
    if profile.css("div.social-icon-container a[href*='twitter']").length != 0 
      student[:twitter] = profile.css("div.social-icon-container a[href*='twitter']").attribute("href").text 
    end 
    
    if profile.css("div.social-icon-container a[href*='linkedin']") != nil 
    student[:linkedin] = profile.css("div.social-icon-container a[href*='linkedin']").attribute("href").text
    end 
    
    if profile.css("div.social-icon-container a[href*='github']") != nil 
    student[:github] = profile.css("div.social-icon-container a[href*='github']").attribute("href").text
    end 
    
    if profile.css("div.social-icon-container a")[3] != nil 
    student[:blog] = profile.css("div.social-icon-container a")[3].attribute("href").text 
    end 
    
    student[:profile_quote] = profile.css("div.profile-quote").text
    student[:bio] = profile.css("div.description-holder p").text
    
    student 
  end
    
end
  
