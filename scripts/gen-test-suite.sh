#!/bin/sh

klass=${1:-"fixture"}
cat <<-EOF
# encoding: UTF-8
require_relative '../test_helper'
EOF
for f in $( cd tests/suites; \
    find $klass \( -name '*.rb' -a -type f \) -print | sed -e 's/.rb$//' ); do
echo "require_relative '$f'";
done
