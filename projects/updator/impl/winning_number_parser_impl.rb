# winning_number_parser_impl.rb define a class which called WinningNumberParserImpl to parse string data from network
# Author: Ares
# History:
#			2014-8-17	-	create
#
#
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'winning_number_parser.rb'
require 'watir-webdriver'

class WinningNumberParserImpl < WinningNumberParser
  def open_start_url
    @b = Watir::Browser.new :chrome
    @b.goto @url
  end

  def get_options
    select = @b.select(:name => "d");

    options = [];

    select.options.each do |option|
      options.push(option.text);
    end
    options
  end

  def select_option(option)
    search_btn = @b.input(:class=> "search-btn");
    select = @b.select(:name => "d");

    select.select(option);
    search_btn.click;
  end

  def sleep_and_wait_for_draw_list(option)
    puts "wait for 5 secs to get data from #{option}"
    sleep(5);

    draw_list = @b.table(:id => 'draw_list');
    draw_list.wait_until_present;
  end

  def get_winning_number_model_from_cells(cells)
    index = 0;
    result = {};

    cells.each do |cell|
      result['date'] = cell.text if index == 0
      result['version'] = cell.text.to_i if index == 1
      result['winnum'] = cell.text if index == 2
      result['money'] = cell.text.to_i if index == 3

      index += 1
    end

    result
  end

  def get_options_from_draw_list
    draw_list = @b.table(:id => 'draw_list');
    draw_list.wait_until_present;
    result = [];

    draw_list.tbody.rows.each do |row|
      result.push(get_winning_number_model_from_cells(row.cells))
    end

    result.flatten
  end

  def get_winning_numbers
    open_start_url
    options = get_options

    result = [];

    options.each do |option|
      select_option(option)
      sleep_and_wait_for_draw_list(option)

      result.push(get_options_from_draw_list);
    end

    result.flatten
  end

  def get_winning_numbers_by(year)
    open_start_url
    options = get_options

    result = [];

    select_option(year)
    sleep_and_wait_for_draw_list(year)
    get_options_from_draw_list
  end
end