class String
  def get_int
    return self.gsub(/[^0-9]/, '').to_i
  end

  def get_float
    return self.gsub(/[^0-9,.]/, '').gsub(',','.').to_f
  end

  def latinize
    polish = {'ą' => 'a', 'ć' => 'c', 'ę' => 'e', 'ł' => 'l', 'ń' => 'n', 'ó' => 'o', 'ś' => 's', 'ź' => 'z', 'ż' => 'z'}
    return self.split(//).map{|letter| polish.keys.include?(letter) ? polish[letter] : letter}.join
  end

  def floorize
    return self.gsub(' ', '_')
  end
end