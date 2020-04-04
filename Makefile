all: b.exe


b.exe: main_dllcaller.o gain.dll
	gcc $< -o b.exe

main_dllcaller.o: main_dllcaller.c
	gcc -c $?

gain.dll: gain.o init.c
	gcc $? -o $@ -shared

a.exe: main.o gain.o
	gcc $? -o $@

main.o: main.c
	gcc -c $?

gain.o: gain.c
	gcc -c $?


clean: main.o gain.o main.exe
	del $?