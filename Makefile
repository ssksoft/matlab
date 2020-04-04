all: a.exe

a.exe: main.o gain.o
	gcc $? -o $@

main.o: main.c
	gcc -c $?

main.o: gain.c
	gcc -c $?


clean: main.o gain.o main.exe
	del $?