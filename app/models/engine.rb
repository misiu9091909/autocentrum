class Engine < ActiveRecord::Base
  belongs_to :generation
  has_many :bodies, :through => :be_combines
  has_many :be_combines
  has_one :rating, :as => :rateable
  has_many :consumptions, :as => :consumable

  def initialize(generation, name, link, type)
    @consumptions = []
    @generation, @name, @link, @engine_type = generation, name, link, type
    years = get_years_from_select(@link)
    @start_year = years[:start]
    @end_year = years[:end]
    @techspec = self.get_techspec
    @rating = Rating.new(self, @link)
    fuel_types = @engine_type == 'benzyna' ? ['pb', 'lpg'] : ['on']
    fuel_types.each{|fuel| @consumptions << Consumption.new(fuel, @link)}
    self.save
  end

  private
  def get_techspec
    site = Nokogiri::HTML(open(@link.gsub('oceny', 'dane-techniczne')))
    techspec = {}
    car_name = site.css('div.dt-title h3').first.text
    site.css('div.dt-param-box').select{|box| box.css('div.dt-date').size > 0}.each do |box|
      subtitle = box.css('h3').first.text.gsub(car_name, '').strip.downcase.latinize
      techspec[subtitle] = {}
      box.css('div.dt-date').each do |entry|
        unit = ''
        unit = entry.css('span.dt-unit').last.text.strip.latinize if entry.css('dt-unit').size > 0
        unit = '' if unit == 'do' || unit == 'od'

        param_name = entry.css('div.dtd-left').first.text + '[' + unit + ']'

        #przypisywanie wartości jeśli jest od do
        if entry.css('span.dt-unit').text.include?('od') && entry.css('span.dt-unit').text.include?('do')
          values = entry.css('div.dtd-right').text.split(/[^0-9.,]/).select{|x| x.size>0}.map{|x| x.get_float}
          [0,1].each{|x| techspec[subtitle][param_name][x] = values[x]}
        else #jeśli jest normalnie
          text = entry.css('div.dtd-right').first.text
          entry.css('span.dt-unit').each{|unit| text.gsub!(unit.text, '')}
          value = text.strip!
          techspec[subtitle][param_name] = (value =~ /\d/) ? value.get_float : value
        end
      end
    end
    return techspec.to_json
  end

end