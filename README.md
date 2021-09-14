# zero-square-asm

To build and run tests:

    $ make tests

The program expects input in format:

    <rows> <cols>
    .. rows lines of cols numbers, space separated

It outputs a matrix, each element is a maximum area possible
for a square of zeroes with that element as the lower-right corner.
