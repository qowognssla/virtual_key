#!/bin/bash
X=0
Y=0

read -p "Please select the input event (/dev/input/event%d) : " inputEvent
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
        k=10
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
    $'\1') # mouse Enter
        echo mouse click!
        luna-send -n 1 palm://com.lge.inputgenerator/pushMouseEvent '{"eventtype":"click"}'
	    ;;
    $'\x1b') # ESC
        echo "esc!"
        read -rsn1 k
        [ "$k" == $'\x1b' ] && echo "esc!!" && k=27     # Esc-Key
        [ "$k" == "[" ] && read -rsn1 k
        [ "$k" == "O" ] && read -rsn1 k
        case "$k" in
        A) # Up
            k=27917965
            ;;
        B) # Down
            k=27917966
            ;;
        C) # Right
            k=27917967
            ;;
        D) #Left
            k=27917968
            ;;
        H) #Home
            k=27917969
            ;;
        1) #Home for windows
            read -rsn1 k    
            if [ $k == ';' ]; then
                read -rsn1 k
                if [ $k == '5' ]; then
                    read -rsn1 k
                    case "$k" in
                    A) # Up      
                        if [ $X != 0 ]; then
                            X="$(($X-15))"
                        fi
                        ;;
                    B) # Down
                        X="$(($X+15))"    
                        ;;
                    C) # Right
                        Y="$(($Y+15))"
                        ;;
                    D) #Left
                        if [ $Y != 0 ]; then
                            Y="$(($Y-15))"
                        fi
                        ;;
                    esac
                    luna-send -n 1 palm://com.lge.inputgenerator/pushMouseEvent '{"eventtype": "setpos","x": "'$Y'", "y": "'$X'"}'
                fi
            else
                k=27917969
            fi
            ;;
        2) #Insert
            read -rsn1 k
            k=27917970
            ;;
        3) #Delete
            read -rsn1 k
            k=27917971
            ;;
        F) #End
            k=27917972
            ;;
        5) #Page-Up
            read -rsn1 k
                echo Page UP
            k=27917973
            ;;
        6) #Page-Down
            read -rsn1 k
            k=27917974
            ;;
        P) #F1
            k=27917976
            ;;
        Q) #F2
            k=27917977
            ;;
        R) #F3
            k=27917978
            ;;
        esac
    esac
    ./virtual_keyboard $inputEvent $k
done