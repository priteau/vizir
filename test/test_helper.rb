require 'rubygems'
require 'test/unit'
require 'shoulda'

require 'fakeweb'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'vizir'

class Test::Unit::TestCase
end
