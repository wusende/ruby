$LOAD_PATH.unshift(File.dirname(__FILE__))

# load required ruby files
require 'app_conf.rb'
require 'model/winning_number'
require 'impl/winning_number_parser_impl'
require 'impl/winning_number_service_impl'
require 'util.rb'
# end load required ruby files

DB_CONFIG_FILE_KEY = 'dbconf';
DB_CONFIG_KEY = 'development';

configure = ApplicationConfig.new
dbconf_file = configure.db(DB_CONFIG_FILE_KEY)

dbconfig = YAML::load(File.open(dbconf_file));
ActiveRecord::Base.establish_connection(dbconfig[DB_CONFIG_KEY]);

# num = WinningNumber.create(:date=> "2003-10-14", :version => '2010223', :winnum => '12 34 56 78 10 10', :money=> 123456);

#  num.save


 #puts num.date
 #puts num.version

#puts WinningNumber.where("version = 201000").empty?
# #
# require 'watir-webdriver'
# b = Watir::Browser.new :chrome
# b.goto 'http://baidu.lecai.com/lottery/draw/list/50/?agentId=5559'

# url = 'http://baidu.lecai.com/lottery/draw/list/50/?agentId=5559';
# number_parser = WinningNumberParserImpl.new(url)
# numbers = number_parser.get_winning_numbers
# number_service = WinningNumberServiceImpl.new
# number_service.save_number(numbers)

#num = WinningNumber.new
#num.winnum = "05 01 10 11 20 31 11";
#puts num.get_red_numbers.join(',')
#puts num.get_blue_num

# puts WinningNumber.class
# update_model(WinningNumber, {
#   :date => "wokao",
#   :version => "22222",
#   :winnum => "33333",
#   :money => "44444" 
# });

numbers = WinningNumber.where('date is not null').to_ary;
red = {}
blue = {}

numbers.each do |number|
  reds = number.get_red_numbers
  reds.each do |per_red|
    red[per_red] = 0 if red[per_red].nil?
    red[per_red] += 1 if not red[per_red].nil?
  end

  per_blue = number.get_blue_num
  blue[per_blue] = 0 if blue[per_blue].nil?
  blue[per_blue] += 1 if not blue[per_blue].nil?

end

red_arr = red.to_a.sort {|x, y| x[1] <=> y[1] }
blue_arr = blue.to_a.sort {|x, y| x[1] <=> y[1] }

puts "-------------------------------------------------------------"
puts "Red Ball mostly be hited: "
puts red_arr.reverse[0, 24].map {|x| x[0]}.shuffle.shuffle.shuffle[0, 6].join(' ')


puts ''
puts "-------------------------------------------------------------"
puts "Blue Ball mostly be hited: "
puts blue_arr.reverse[0, 12].map {|x| x[0]}.shuffle.shuffle.shuffle[0]
