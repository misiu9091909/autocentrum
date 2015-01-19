
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
    return 'http://autocentrum.pl' + link if link[0] == '/'
    return url + link if url.class == String
  end
  return link
end

def get_ratings_count_from_card(site)
  return site.css('div.ac-box-center h2').text.gsub!(/[^0-9]/, '').to_i
end

def get_years_from_select(site)
  site = Nokogiri::HTML(open(site)) unless site.class == Nokogiri::HTML::Document
  years = {start: site.css('select.ac-select').find{|dom| dom['name'] == 'years_from'}.css('option').first.text.get_int, end: site.css('select.ac-select').find{|dom| dom['name'] == 'years_from'}.css('option').last.text.get_int }
  return years
end