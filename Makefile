all: b.exe


b.exe: main_dllcaller.o gain.dll
	gcc $< -o b.exe

main_dllcaller.o: main_dllcaller.c
	gcc -c $?

gain.dll: gain.o
	gcc $? -o $@ -shared

gain.o: gain.c
	gcc -c $?
clean:
	powershell.exe del '*.o'