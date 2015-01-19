class Kind < ActiveRecord::Base
  include Processing
  belongs_to :brand
  has_many :generations

  attr_accessor :generations
  attr_reader :brand, :name, :link, :start_year, :end_year, :segment, :general_link
  def initialize(brand, name, link)
    @generations = []
    @brand = brand
    @name = name
    @link = link
    general_info_site = Nokogiri::HTML(open(link.gsub('oceny/', '')))
    info_about_model = general_info_site.css('ul.box_right3')[0]
    years = process_years(info_about_model.css('li')[1].text.strip)
    @start_year = years[:start]
    @end_year = years[:end]
    @segment = info_about_model.css('li')[7].text.strip.downcase
    @original_parts = info_about_model.css('img').select{|img| img['src'].include?('dolar_big1.jpg')}.size
    @original_parts = nil if @original_parts == 0
    @replacement_parts = info_about_model.css('img').select{|img| img['src'].include?('dolar_small1.jpg')}.size
    @replacement_parts = nil if @replacement_parts == 0
    get_generations
    self.save
  end

  private
  def get_generations
    generations_site = Nokogiri::HTML(open(self.link))
    if generations_site.text.to_s.downcase.include?('lista generacji')
      generations_site.css('div.cb-generation').each do |entry|
        years = process_years(entry.css('span')[1].text.strip)
        name = entry.css('span').first.text.gsub(entry.css('span')[1].text, '').strip
        link = correct_link(entry.css('a').first['href'], self.link)
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
