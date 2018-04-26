# encoding: UTF-8
require_relative '../../test_helper'

class TestFixturePresence < Test::Unit::TestCase
    include TestMethods
    def setup
        fixtures_dir = File.expand_path("../../../fixtures",__FILE__)
        @input_fixture = File.expand_path("#{fixtures_dir}/input.txt",__FILE__)
        @output_fixture = File.expand_path("#{fixtures_dir}/output.txt",__FILE__)
    end

    def teardown
    end

    def test_input_fixture_has_spiderman_search_term
        assert_content_exists_on_disk @input_fixture, "spiderman"
    end
    def test_output_fixture_has_spiderman_search_term
        assert_content_exists_on_disk @output_fixture, <<-EOS
Amazing Spiderman Syndrome
Fighting, Flying and Driving: The Stunts of Spiderman 3
Hollywood's Master Storytellers: Spiderman Live
Italian Spiderman
Spiderman
Spiderman
Spiderman 5
Spiderman and Grandma
Spiderman in Cannes
Superman, Spiderman or Batman
The Amazing Spiderman T4 Premiere Special
The Death of Spiderman
They Call Me Spiderman
EOS
    end
end
