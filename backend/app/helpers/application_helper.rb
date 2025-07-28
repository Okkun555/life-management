module ApplicationHelper
  def format_datetime(datetime)
    raise ArgumentError, 'datetime is empty' if datetime.blank?

    datetime.strftime('%Y/%m/%d %H:%M:%S')
  end
end
