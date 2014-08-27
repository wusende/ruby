# util.rb define a some util collection to make coding more easy
# Author: Ares
# History: 
#     2014-8-17 - create 
#
#
$LOAD_PATH.unshift(File.dirname(__FILE__))

def update_model(klass, attr)
  model = klass.new
  model.update_attributes(attr);
end