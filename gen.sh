#!/bin/sh

BASENAME=${BASENAME:-"/usr/bin/basename"}
PRINTF=${PRINTF:-"/usr/bin/printf"}
PERL=${PERL:-"/usr/bin/perl"}
TR=${TR:-"/usr/bin/tr"}
SED=${SED:-"/bin/sed"}
ECHO=${ECHO:-"/bin/echo"}
MKDIR=${MKDIR:-"/bin/mkdir"}
MKDIR_P=${MKDIR_P:-"${MKDIR} -p"}
GEN_TEST_CASE=${GEN_TEST_CASE:-"./scripts/gen-test-case.sh"}
GEN_TEST_SUITE=${GEN_TEST_SUITE:-"./scripts/gen-test-suite.sh"}

APP_NAME=`${BASENAME} $0`

usage()
{
    ${PRINTF} "usage: %s test-suite test-case-1 .. test-case-n\n" "$APP_NAME";
}

die()
{
   ${PRINTF} "%s\n" "$@";
   exit 1;
}

exit_failure()
{
    die "`usage`";
}

# convert names like FooBar to foo_bar
to_unscore_case()
{
    ${PERL} -pe 's/([a-z0-9])([A-Z])/$1_\L$2/g' \
        | ${TR} '[:upper:]' '[:lower:]';
}

# remove components from names that will be added back where appropriate
strip_test_filename_components()
{
  ${SED} -e '
        /^test_/{   s///; };
        /.rb$/{     s///;   }; ';
}

# convert names like TestFooBar to foo_bar
to_test_case_stem()
{
    ${ECHO} $test_case \
        | to_unscore_case \
        | strip_test_filename_components
}

to_test_case_name()
{
    ${PRINTF} "test_%s_%s.rb\n" "${test_suite}" "`to_test_case_stem`";
}

# generate a test for test case name
mktestcase()
{
    local fname="tests/suites/${test_suite}/`to_test_case_name`"
    ${ECHO} $fname;
    ${GEN_TEST_CASE} $test_case > "${fname}";
}

# generate a suite incorporating all test cases found in suite directory
mktestsuite()
{
    local fname="tests/suites/${test_suite}.rb"

    # generate a test for each test case name
    while [ "$#" -gt 0 ]; do
        test_case=$1
        shift 1;
        mktestcase;
    done

    # generate a test for each test case name
    ${ECHO} $fname;
    ${GEN_TEST_SUITE} ${test_suite} > "${fname}";
    exit 0
}

# suite names are mandatory
test_suite=${1:-"Missing"};
if [ "x$test_suite" = "xMissing" ] ; then
    exit_failure;
else
    # generate a suite incorporating all test cases found in suite directory
    shift $(( $# > 0 ? 1 : 0 ))
    test_case_names="$@"
    mktestsuite $test_case_names
fi
