# app_conf.rb define a class which called ApplicationConfig to load application configure file
# Author: Ares
# History: 
#			2014-8-17	-	create 
#
#
require 'yaml'

class ApplicationConfig
	
	def initialize(config_file="app.conf")
		@config_file = config_file;
		load(@config_file);
	end

	def load(config)
		begin
			@configure = YAML::load(File.open(config));
		rescue => err
			puts err
			raise LoadError.new(err)
		end
	end
	
	def reload()
		load(@config_file);
	end
	
	def save()
		
	end
	
	def get(key="")
		getValue(@configure, key);
	end
	
	def db(key="")
		getValue(get("db"), key)
	end
	
	def getValue(obj, key) 
		return obj if key == "";
		return obj[key];
	end
end
