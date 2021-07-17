gem 'minitest', '~>5'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/runplan'

class RunPlanTest < Minitest::Test
    def test_basic_runplan
        expected = ""
        assert_equal expected, RunPlan.new.week(1)
    end
end