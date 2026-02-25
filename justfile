build:
    customasm assembly/main.asm -o bin/main.bin

debug:
    customasm assembly/main.asm -f annotatedbin -o bin/main.txt
