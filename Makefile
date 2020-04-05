all: b.exe wrapper_matlab.dll


b.exe: main_dllcaller.o gain.dll
	gcc $< -o b.exe

wrapper_matlab.dll: wrapper_matlab.c
	gcc -shared $? -o $@

main_dllcaller.o: main_dllcaller.c
	gcc -c $?

gain.dll: gain.o
	gcc -shared $? -o $@

gain.o: gain.c
	gcc -c $?
clean:
	powershell.exe del '*.o'