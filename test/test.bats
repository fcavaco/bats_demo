#!./test/libs/bats/bin/bats

load './libs/bats-support/load';
load './libs/bats-assert/load';

source './test.bash';

@test "when -s argument is not alphanumeric, it fails." {

    declare -r solname="%&ABC$$";
    run validateSolutionArg $solname;
     
    assert_failure 1; # as the script will exit with 1 for bad arguments
    assert_line "Solution name should be an alphanumeric string. Received : [$solname]";
   
}

@test "when -s argument is alphanumeric, it succeeds." {
    declare -r solname="IAMASOLUTION123";
    run validateSolutionArg $solname;
    assert_success;
}

@test "when -s option not passed, fails with code 1 and prints invalid message to stderr" {
    run test_options
    assert_failure 1;
    assert_line "Solution argument is always required as that forms the basis of the root directory for the solution.";
 
}

@test "when -s option is passed with valid alphanumeric string, should succeed." {
    declare -r solname="IAMASOLUTION123";
    run test_options -s $solname
    assert_success;
}
