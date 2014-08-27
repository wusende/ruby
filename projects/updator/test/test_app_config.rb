require 'test/unit'
require '../app_conf.rb'
class MyTest < Test::Unit::TestCase
	def test_load()
		assert_nothing_raised do
			config = ApplicationConfig.new("../app.conf");
		end
		
		assert_raise LoadError do
			config = ApplicationConfig.new;
		end
	end
	
	def test_reload()
		
	end
end