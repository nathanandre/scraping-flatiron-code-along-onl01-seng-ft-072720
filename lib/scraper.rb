require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  def get_page
    #use Nokogiri and open-uri to get all HTML from webpage
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end

  end

  def get_courses
    #use CSS selector to grab all HTML elements that contain a course
    #return value is a collection of XML elements, each of which describes a course
    #inspect website to find CSS selector the contains the courses
    self.get_page.css(".post")
  end

  def make_courses
    #instantiates Course objects, giving each one the correct title, schedule, and description
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end



  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses



