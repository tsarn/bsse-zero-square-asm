main:
	$(CC) main.s -no-pie -g -o main

tests: main
	./run_tests.sh	

clean:
	rm -f main

.PHONY: clean tests
