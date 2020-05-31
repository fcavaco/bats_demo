#!./test/libs/bats/bin/bats

load './libs/bats-support/load'
load './libs/bats-assert/load'

source './dotnethelper.sh'

@test "Should add numbers together" {
    assert_equal $(echo 1+1 | bc) 2
}