class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  attr_accessor :rates, :ratings_count, :again, :again_count

  def initialize(rateable, link)
    @rateable = rateable
    site = Nokogiri::HTML(open(link))
    if site.css('div#main-ajax-content h2').first.text =~ /\d/ # jeżeli są jakiekolwiek oceny
      @ratings_count = site.css('div#main-ajax-content h2').first.text.get_int
      @rates = get_ratings(site)
    else
      @ratings_count = 0
    end
    if site.text.include?('jeszcze raz?')
      @again = site.css('div.ac-barchart-score-left').first.text.get_int
      @again_count = site.css('div.osasrrb-based').first.text.get_int
    else
      @again_count = 0
    end
    self.save
  end

  private
  def get_ratings(site)
    rates_h = {}
    site.css('div.osa-summary-result').each {|rate| rates_h[rate.css('div.osasr-name').first.text.downcase.latinize] = rate.css('span.ac-numeric-result-value').first.text.get_float }
    return rates_h.to_json
  end
end
