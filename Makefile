OBJS = hashtable.o hashtableTester.o

OUTPUT = hashtableTester

CC=clang

CFLAGS=-std=c99 -g -Wall -Werror -Wconversion -pedantic

$(OUTPUT): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $^

test: $(OUTPUT)
	#valgrind --quiet --leak-check=full --track-origins=yes ./smartArrayTester <q1input.txt | tee q1output.txt
	# diff q1output.txt q1ref_output.txt
	valgrind --quiet --leak-check=full --track-origins=yes ./$(OUTPUT)
clean:
	rm -f *.o $(OUTPUT)
