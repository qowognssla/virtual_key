#include "virtual_keyboard.h"

static int ufd = -1;
//static struct input_event data;
static struct input_event event; // Input device structure

static int init_device(char *EVT_DEV)
{
    if((ufd = open(EVT_DEV, O_RDWR)) < 0)
    {
        printf("Error open %s\n\n", EVT_DEV);
        return -1;
    }
    return ufd;
}

static int test_key(char *INPUT_DEV, int value)
{
    if (init_device(INPUT_DEV) < 0)
        return -1;
    
    if (isShift) {
        memset(&event, 0, sizeof(event));
        event.type = EV_KEY;
        event.value = 1;
        event.code = KEY_LEFTSHIFT;
        write(ufd, &event, sizeof(event));
        event.type = EV_SYN;
        event.code = SYN_REPORT;
        event.value = 0;
        write(ufd, &event, sizeof(event));
    }

    memset(&event, 0, sizeof(event));
    event.type = EV_KEY;
    event.value = 1;
    event.code = value;
    write(ufd, &event, sizeof(event));
    event.type = EV_SYN;
    event.code = SYN_REPORT;
    event.value = 0;
    write(ufd, &event, sizeof(event));

    memset(&event, 0, sizeof(event));
    event.type = EV_KEY;
    event.value = 0;
    event.code = value;
    write(ufd, &event, sizeof(event));
    event.type = EV_SYN;
    event.code = SYN_REPORT;
    event.value = 0;
    write(ufd, &event, sizeof(event));

    if (isShift) {
        memset(&event, 0, sizeof(event));
        event.type = EV_KEY;
        event.value = 0;
        event.code = KEY_LEFTSHIFT;
        write(ufd, &event, sizeof(event));
        event.type = EV_SYN;
        event.code = SYN_REPORT;
        event.value = 0;
        write(ufd, &event, sizeof(event));
    }

    return 0;
}

int main(int argc, char* argv[])
{
    char dev[128] = {0};

    if(argc != 3) {
        printf("please check arguments\n");
        return 0;
    }
    sprintf(dev, "/dev/input/event%s", argv[1]);
    int keycode = IsShifted(atoi(argv[2]));
    test_key(dev, getKeycode(keycode));
    return 0;
}

