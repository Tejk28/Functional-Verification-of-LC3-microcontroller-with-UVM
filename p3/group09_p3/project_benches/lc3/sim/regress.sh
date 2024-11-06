rm -rf *ucdb
make clean
make libs
make build
make link
make optimize
make run_cli TEST_NAME=test_top TEST_SEED=1234 
make run_cli TEST_NAME=alu_test TEST_SEED=1234
make run_cli TEST_NAME=br_test TEST_SEED=1234
make run_cli TEST_NAME=br_st_test TEST_SEED=1234
make run_cli TEST_NAME=br_ld_test TEST_SEED=1234
make run_cli TEST_NAME=ld_test TEST_SEED=1234
make run_cli TEST_NAME=ldpc_test TEST_SEED=1234
make run_cli TEST_NAME=ldrpc_test TEST_SEED=1234
make run_cli TEST_NAME=ldipc_test TEST_SEED=1234
make run_cli TEST_NAME=leapc_test TEST_SEED=1234
make run_cli TEST_NAME=st_test TEST_SEED=1234
make run_cli TEST_NAME=stpc_test TEST_SEED=1234
make run_cli TEST_NAME=stipc_test TEST_SEED=1234
make run_cli TEST_NAME=strpc_test TEST_SEED=1234
make merge_coverage_with_test_plan
