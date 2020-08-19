#!/bin/bash
X=0
Y=0

while IFS= read -rsn1 k # Read one key (first byte in key press)
do
    case "$k" in
    [[:graph:]])
        # Normal input handling
        k=$(printf '%d' "'$k")
        echo KeyCode : $k
        ;;
    "") # Enter
        echo Enter pressed!
        luna-send -n 1 palm://com.lge.inputgenerator/pushMouseEvent '{"eventtype":"click"}'
        ;;
    $'\x20') # space
        echo Space pressed!
        k=32
        ;;  
    $'\b') # Back-Space
        # Routine for back-space
        echo BackSpace pressed!
        k=127
        ;;
    $'\x7f') # Back-Space
        # Routine for back-space
        echo BackSpace pressed!
        k=127
        ;; 
    $'\t') # tab
        k=10001
	    echo Tab pressed!
	    ;;
    $'\x1b') # ESC
        read -rsn1 k
        [ "$k" == $'\x1b' ] && echo "esc!!" && k=27     # Esc-Key
        [ "$k" == "[" ] && read -rsn1 k
        [ "$k" == "O" ] && read -rsn1 k
        case "$k" in
        A) # Up      
            if [ $X != 0 ]; then
                X="$(($X-15))"
            fi
            ;;
        B) # Down

            X="$(($X+15))"    
            echo $X
            ;;
        C) # Right
            Y="$(($Y+15))"
            echo $Y
            ;;
        D) #Left
            if [ $Y != 0 ]; then
                Y="$(($Y-15))"
            fi
            echo $Y
            ;;
        esac
        luna-send -n 1 palm://com.lge.inputgenerator/pushMouseEvent '{"eventtype": "setpos","x": "'$Y'", "y": "'$X'"}'    
    esac
done