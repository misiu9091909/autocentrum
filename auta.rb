require 'nokogiri'
require 'open-uri'
require 'singleton'
require 'active_record'
require 'mysql2'

MAIN_URI = 'http://autocentrum.pl/oceny'

class Catalog
  include Singleton
  attr_reader :brands
  def initialize
  end
  def download
    brands_site = Nokogiri::HTML(open(MAIN_URI))
    @brands = []
    brands_site.css('div.sib-name').each{|entry| @brands << Brand.new(entry.text, correct_link(entry.css('a')[0]['href'], MAIN_URI))}
  end
end

class Brand < ActiveRecord::Base
  attr_accessor :name, :link, :models
  def initialize(name, link)
    @models = []
    @name = name
    @link = link
    
    models_site = Nokogiri::HTML(open(self.link))
    #dodawanie modeli aut 
    models_site.css('div.sib-name-part').each{|entry| self.models << Model.new(self, entry.text, correct_link(entry.css('a')[0]['href'], self.link))}
  end
end
class Model < ActiveRecord::Base
  attr_accessor :generations
  attr_reader :brand, :name, :link, :start_year, :end_year, :segment, :general_link
  def initialize(brand, name, link)
    @generations = []
    @brand = brand
    @name = name
    @link = link
    @general_link = link.gsub('oceny/', '')
    general_info_site = Nokogiri::HTML(open(@general_link))
    info_about_model = general_info_site.css('ul.box_right3')[0]
    years = process_years(info_about_model.css('li')[1].text.strip)
    @start_year = years[:start]
    @end_year = years[:end]
    @segment = info_about_model.css('li')[7].text.strip.downcase
    get_generations
  end
  
  private
  def get_generations
    generations_site = Nokogiri::HTML(open(self.link))
    if generations_site.text.to_s.downcase.include?('lista generacji')
      generations_site.css('div.sib-name-part').each do |entry|
        years = process_years(entry.css('span')[0].text.strip)
        name = entry.text[entry.css('span')[0].text.length..-1].strip
        link = correct_link(entry.css('a')[0]['href'], self.link)
        self.generations << Generation.new(self, name, link, years)
      end
    else
      name = 'I'
      years = {start: self.start_year, end: self.end_year}
      link = self.link
      self.generations << Generation.new(self, name, link, years)
    end
  end
end
class Generation < ActiveRecord::Base
  attr_accessor :name, :link, :years, :bodies, :engines :ratings, :ratings_count
  attr_reader :model
  def initialize(model, name, link, years)
    @bodies = []
    @engines = []
    @model = model
    @name = name
    @link = link
    @start_year = years[:start]
    @end_year = years[:end]
    
    bodies_engines_site = Nokogiri::HTML(open(@link))
    if bodies_engines_site.css('div.ac-box-center h2') =~ /\d/ # jeżeli są jakiekolwiek oceny
      @ratings = get_ratings(bodies_engines_site)
      @ratings_count = get_ratings_count_from_card(bodies_engines_site)
    end
    
  end
end
class Body < ActiveRecord::Base
  attr_accessor :name, :link, :start_year, :end_year, :ratings, :ratings_count
  attr_reader :generation
  def initialize(generation, name, link)
    @generation = generation
    @name = name
    @link = link
    @ratings = {}
  end
end
class Engine < ActiveRecord::Base
  attr_accessor :name, :link, :start_year, :end_year, :fuel_type, :ratings, :ratings_count
  attr_reader :generation
  def initialize(body, name, fuel_type, link, years)
    @name = name
    @link = link
    @fuel_type = fuel_type
    @start_year = years[:start]
    @end_year = years[:end]
    @ratings = {}
  end
end
class RatingList < ActiveRecord::Base
  attr_reader :generation, :body, :engine
      
  def initialize(generation, body, engine, link)
    
  end
  private
  def get_ratings(site)
    ratings = {}
    ratings['Średnia ocena'] = site.css('span.ac-numeric-result-value')[0].text.gsub(',','.').to_f
    site.css('div.osa-summary-result').each {|rate| ratings[rate.css('div.osasr-name')[0].text] = rate.css('span.ac-numeric-result-value')[0].text.gsub(',','.').to_f }
    ratings['Jeszcze raz?'] = site.text.include?('jeszcze raz?') ? site.css('div.ac-barchart-score-left')[0].text[0..-2].to_f/100 : 0   #zapobieżenie brakowi ocen "jeszcze raz"
    return ratings
  end
end
class Combine < ActiveRecord::Base
  
end

def process_years(years)
  start_year = years[0..3]
  if years.include?('-')
    end_year = years.include?('teraz') ? Time.now.to_s[0..3] : years[-4..-1]
  else
    end_year = start_year
  end
  return {start: start_year.to_i, end: end_year.to_i}
end

def correct_link(link, url)
  if link
    return link if link.include?('autocentrum.pl')
    return 'http://autocentrum.pl' + link if link[0] = '/'
    return url + link if url.class == String
  end
  return link
end

def get_ratings_count_from_card(site)
  return site.css('div.ac-box-center h2').text.gsub!(/[^0-9]/, '').to_i
end

#wywołanie
Catalog.instance.download