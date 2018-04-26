#!/bin/sh

klass=${1:-"TestThing"}
cat <<-EOF
# encoding: UTF-8
require_relative '../../test_helper'
class $klass < Test::Unit::TestCase
    def setup
    end
    def teardown
    end
end
EOF
