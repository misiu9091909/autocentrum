class Brand < ActiveRecord::Base
  include Processing
  has_many :kinds

  attr_accessor :name, :link, :kinds
  def initialize(name, link)
    @name = name
    @link = link

    kinds_site = Nokogiri::HTML(open(self.link))
    #dodawanie modeli aut
    kinds_site.css('div.cb-models').each{|entry| @kinds << Kind.new(self, entry.css('span')[0].text, correct_link(entry.css('a')[0]['href'], self.link))}
    self.save
  end
end
