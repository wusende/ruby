# winning_number_service_impl.rb define a class which called WinningNumberServiceImpl to parse string data from network
# Author: Ares
# History:
#			2014-8-17	-	create
#
#
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'winning_number_service.rb'
require 'model/winning_number.rb'

class WinningNumberServiceImpl < WinningNumberService

  def delete_number(number_id)
    query = WinningNumber.where("version = #{number_id}")

    query.to_ary.each do |num|
      num.delete
    end
  end

  def get_number(version_id)
    query = WinningNumber.where("version = #{number_id}")
    return nil if query.empty?
    query.first
  end

  def save_number(numbers)
    numbers.each do |number|
      query = WinningNumber.where("date = '#{number['date']}'");

      numObj = WinningNumber.create(
          :date => number['date'],
          :version => number['version'],
          :winnum => number['winnum'],
          :money => number['money']) if query.empty?
      numObj = query.first if !query.empty?
    end
  end

  def get_numbers(year)
    query = WinningNumber.where("version > #{year}000 and version < #{year}999")
    return [] if query.empty?
    query.to_ary
  end
end