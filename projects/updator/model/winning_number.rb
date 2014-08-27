# winning_number.rb define a class which called WinningNumber to parse string data from network
# Author: Ares
# History:
#			2014-8-17	-	create
#
#
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'active_record'
require 'winning_number_service.rb'

require 'date'

class WinningNumber < ActiveRecord::Base
  def get_red_numbers
    return [] if winnum.nil? or winnum.empty?
    result = winnum.strip.split
    result[0, 6]
  end

  def get_blue_num
    return [] if winnum.nil? or winnum.empty?
    result = winnum.strip.split
    result[result.length - 1]
  end
end
