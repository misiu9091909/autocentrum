class Generation < ActiveRecord::Base
  belongs_to :kind
  has_many :bodies
  has_many :engines
  has_one :rating, :as => :rateable

  attr_accessor :name, :link, :years, :bodies, :engines, :rating
  attr_reader :kind
  def initialize(kind, name, link, years)
    @bodies = []
    @engines = []
    @kind, @name, @link, @start_year, @end_year = kind, name, link, years[:start], years[:end]
    @rating = Rating.new(self, @link)

    self.get_engines
    self.get_bodies
    @bodies.each {|body| body.get_be_combines}
    self.save
  end

  private
  def get_engines
    be_site = Nokogiri::HTML(open(@link))

  end
  def get_bodies

  end
end
