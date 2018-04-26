#!/bin/sh

klass=${1:-"TestThing"}
cat <<-EOF
# encoding: UTF-8
require_relative '../../test_helper'
class $klass < Test::Unit::TestCase
    include TestMethods

    def setup
        fixtures_dir = File.expand_path("../../../fixtures",__FILE__)
    end
    def teardown
    end
end
EOF
