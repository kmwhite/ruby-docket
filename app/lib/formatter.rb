module Formatter

  require 'github/markup'

  DATE_FORMAT='%Y-%m-%d'

  def self.format_date(date)
    date.try(:strftime, DATE_FORMAT) || '(null)'
  end

  def self.format_time(time, options = {format: '%Y-%m-%d %H:%M:%S'})
    time.strftime(options[:format])
  end

  def self.format_percent(pct)
    unless pct.nil?
      "#{(pct*100.0).round(2)}%"
    else
      '0.0%'
    end
  end

  def self.format_markdown(str)
    !str.nil? ? GitHub::Markup.render('body.markdown', str) : ''
  end
end
