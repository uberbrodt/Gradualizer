#
# compile the project
# > make app
#
# start a shell
# > make shell
#
# run unit tests
# > make eunit
#
# run tests with coverage
# > make tests COVER=1 && open cover/index.html
#
# run dialyzer
# > make dialyze
#
# run gradualizer on itself
# > make gradualize
#
# run all checks (including tests, dialyze and gradualize)
# > make check
#
PROJECT = gradualizer

PLT_APPS = kernel stdlib compiler crypto
DIALYZER_OPTS = -Werror_handling

include erlang.mk

gradualize: app
	$(ERL) -pa $(CURDIR)/ebin -eval 'gradualizer:type_check_file("src/typechecker.erl"), halt().'
check:: gradualize

# We want warnings to be warnings, not errors.
ERLC_OPTS := $(filter-out -Werror,$(ERLC_OPTS))

EUNIT_OPTS = verbose

# Unit test files to run
EUNIT_TEST_SOURCES = $(shell ls $(TEST_DIR)/*.erl)

# Override erlang.mk variable to only run unit test modules
# (results in a bit less noisy output)
# (Other it tried to compile and run all source files
#  recursively in all subdirs of test)
EUNIT_TEST_MODS = $(notdir $(basename $(EUNIT_TEST_SOURCES)))
