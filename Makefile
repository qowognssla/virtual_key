include MakeConfig

MYDEFS          =
rm              = /bin/rm -f
cp              = /bin/cp -f

CC              = $(MYCXX)
TARGET			= virtual_keyboard
OBJS			= virtual_keyboard.o
CFLAGS			= -Werror=unused-result
all : clean $(OBJS)
	$(CC) -o $(TARGET) $(OBJS)

#this for destop bin 
dt : clean
	/bin/gcc -c -o virtual_keyboard.o virtual_keyboard.c
	/bin/gcc -o $(TARGET) $(OBJS)

virtual_keyboard.o : virtual_keyboard.c
	$(CC) -c -o virtual_keyboard.o virtual_keyboard.c

mm : clean
	/bin/gcc -c -o virtual_mouse.o virtual_mouse.c
	/bin/gcc -o virtual_mouse virtual_mouse.o


clean : 
	rm -rf $(OBJS) $(TARGET) virtual_mouse virtual_mouse.o
