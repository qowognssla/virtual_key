#include <linux/input.h>
#include <linux/uinput.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <sys/types.h>
#include <signal.h>
#include <termios.h>
#include <unistd.h>

// cat /proc/bus/input/devices 
int isShift = 1;


int getKeycode(int value)
{
    switch (value)
    {
    case 27: //ESC
        return 174; // Button EXIT  //KEY_ESC;
    case 45: //Minus
        return KEY_MINUS;
    case 61: //Equal
        return KEY_EQUAL;
    case 127:
        return KEY_BACKSPACE;
    case 10001:
        return KEY_TAB;
    case 113:
        return KEY_Q;
    case 119:
        return KEY_W;
    case 101:
        return KEY_E;
    case 114:
        return KEY_R;
    case 116:
        return KEY_T;
    case 121:
        return KEY_Y;
    case 117:
        return KEY_U;
    case 105:
        return KEY_I;
    case 111:
        return KEY_O;
    case 112:
        return KEY_P;
    case 91:
        return KEY_LEFTBRACE;
    case 93:
        return KEY_RIGHTBRACE;
    case 10:
        return KEY_ENTER;
    case 97:
        return KEY_A;
    case 115:
        return KEY_S;
    case 100:
        return KEY_D;
    case 102:
        return KEY_F;
    case 103:
        return KEY_G;
    case 104:
        return KEY_H;
    case 106:
        return KEY_J;
    case 107:
        return KEY_K;
    case 108:
        return KEY_L;
    case 59:
        return KEY_SEMICOLON;
    case 39:
        return KEY_APOSTROPHE;
    case 96:
        return KEY_GRAVE;
    case 92:
        return KEY_BACKSLASH;
    case 122:
        return KEY_Z;
    case 120:
        return KEY_X;
    case 99:
        return KEY_C;
    case 118:
        return KEY_V;
    case 98:
        return KEY_B;
    case 110:
        return KEY_N;
    case 109:
        return KEY_M;
    case 44:
        return KEY_COMMA;
    case 46:
        return KEY_DOT;
    case 47:
        return KEY_SLASH;
    case 32:
        return KEY_SPACE;
    case 27917965:
        return KEY_UP;
    case 27917966:
        return KEY_DOWN;
    case 27917967:
        return KEY_RIGHT;
    case 27917968:
        return KEY_LEFT;
    case 27917969:   
        return 773; // Studio Key - Home
    case 27917970:  
        return 899; // In Start Key - insert
    case 27917971:
        return 898; // In Stop Key - delete
    //case 27917972:
    //    return 889; 
    case 27917973:
        return 402; // CH UP - page up
    case 27917974:
        return 403; // CH DOWN - page down
    //case 27917975:
    //    return 898; // In Stop
    case 27917976:
        return 115; // Volume Up
    case 27917977:
        return 114; // Volume Down
    }

    // Digit Number
    if ( value >= 49 && value <=57)
        return (value - 47);
    else if (value == 48 )
        return 11;
}

int IsShifted(int value) {
    if ( value >= 65 && value <= 90 ) {
        return value + 32 ;
    }

    switch (value){
        case 126:       // ~
            return 96;
        case 33:        //!
            return 49;
        case 64:        // @
            return 50;
        case 35:        // #
            return 51;
        case 36:        // $
            return 52;
        case 37:        // %
            return 53;
        case 94:        // ^
            return 54;
        case 38:        // &
            return 55;
        case 42:        // *
            return 56;
        case 40:        // (
            return 57;
        case 41:        // )
            return 48;
        case 95:        // _
            return 45; 
        case 43:        // +
            return 61;
        case 124:       // |
            return 92;
        case 123:       // {
            return 91;
        case 125:       // }
            return 93;
        case 58:        // :
            return 59;
        case 34:        // "
            return 39;
        case 60:        // <
            return 44;
        case 62:        // >
            return 46;
        case 63:        // ?
            return 47;
    }

    isShift = 0;
    return value;
}