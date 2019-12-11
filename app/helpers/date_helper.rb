module DateHelper
  def date_to_string(date_object)
    "#{date_object.year}#{format('%02i', date_object.month)}#{format('%02i', date_object.day)}"
  end

  def string_to_date(date_string)
    Date.new(date_string[0...4].to_i, date_string[4...6].to_i, date_string[6...8].to_i)
  end
end
