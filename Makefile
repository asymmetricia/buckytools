RM = rm -f
targets=bucky  bucky-fill  bucky-isempty  bucky-pickle-relay  bucky-sparsify  buckyd  findhash  gentestmetrics

PHONY: all

all: $(targets)

bucky:
	go build -mod vendor ./cmd/$@

bucky-fill:
	go build -mod vendor ./cmd/$@

bucky-isempty:
	go build -mod vendor ./cmd/$@

bucky-pickle-relay:
	go build -mod vendor ./cmd/$@

bucky-sparsify:
	go build -mod vendor ./cmd/$@

buckyd:
	go build -mod vendor ./cmd/$@

findhash:
	go build -mod vendor ./cmd/$@

gentestmetrics:
	go build -mod vendor ./cmd/$@

# To keep testdata after running test for debugging, run the following command:
#
# 	make test REBALANCE_FLAGS=-keep-testdata
#
test: clean bucky buckyd
	go run -mod vendor testing/rebalance.go $(REBALANCE_FLAGS)
	go run -mod vendor testing/copy.go $(COPY_FLAGS)

# only works on linux
test_rebalance_health_check_setup:
	sudo ip addr add 10.0.1.7 dev lo
	sudo ip addr add 10.0.1.8 dev lo
	sudo ip addr add 10.0.1.9 dev lo

test_rebalance_health_check: clean bucky buckyd
# 	go run -mod vendor testing/rebalance_health_check.go $(REBALANCE_FLAGS)

clean_test:
	rm -rf testdata_rebalance_*
	rm -rf testdata_copy_*

clean:
	$(RM) $(targets)
