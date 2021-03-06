/* ************************************************************************/
/* FONT *******************************************************************/
/* ************************************************************************/
/* index in the array   0 1 2 3 4 5 6 7 8 9 10 11           12
   Characters:          0 1 2 3 4 5 6 7 8 9 :  {full white} {full dark}
   Note:
   1st coordinate in the array: the index in the array (see above)
   2nd coordinate in the array: the Y (!!) coordinate
   3nd coordinate in the array: the X coordinate
*/
font_nb_pixel_x = 4;    // 4 pixels wide
font_nb_pixel_y = 6;    // 6 pixels high

font_char = [[
    [0,1,1,0],	//index 0: character "0"
    [1,0,0,1],
    [1,0,1,1],
    [1,1,0,1],
    [1,0,0,1],
    [0,1,1,0],
],[
    [0,1,0,0],	//index 1: character "1"
    [1,1,0,0],
    [0,1,0,0],
    [0,1,0,0],
    [0,1,0,0],
    [1,1,1,0],
],[
    [0,1,1,0],	//index 2: character "2"
    [1,0,0,1],
    [0,0,0,1],
    [0,1,1,0],
    [1,0,0,0],
    [1,1,1,1],
],[
    [0,1,1,0],	//index 3: character "3"
    [1,0,0,1],
    [0,0,1,1],
    [0,0,0,1],
    [1,0,0,1],
    [0,1,1,0],
],[
    [1,0,0,1],	//index 4: character "4"
    [1,0,0,1],
    [1,0,0,1],
    [1,1,1,1],
    [0,0,0,1],
    [0,0,0,1],
],[
    [1,1,1,1],	//index 5: character "5"
    [1,0,0,0],
    [1,1,1,0],
    [0,0,0,1],
    [0,0,0,1],
    [1,1,1,0],
],[
    [0,1,1,1],	//index 6: character "6"
    [1,0,0,0],
    [1,1,1,0],
    [1,0,0,1],
    [1,0,0,1],
    [0,1,1,0],
],[
    [1,1,1,1],	//index 7: character "7"
    [0,0,0,1],
    [0,0,0,1],
    [0,0,1,0],
    [0,1,0,0],
    [1,0,0,0],
],[
    [0,1,1,0],	//index 8: character "8"
    [1,0,0,1],
    [0,1,1,0],
    [1,0,0,1],
    [1,0,0,1],
    [0,1,1,0],
],[
    [0,1,1,0],	//index 9: character "9"
    [1,0,0,1],
    [1,0,0,1],
    [0,1,1,1],
    [0,0,0,1],
    [1,1,1,0],
],[
    [0,0,0,0],	//index 10: character ":"
    [0,0,0,0],
    [0,1,0,0],
    [0,0,0,0],
    [0,1,0,0],
    [0,0,0,0],
],[
    [1,1,1,1],	//index 11: character {full white}
    [1,1,1,1],
    [1,1,1,1],
    [1,1,1,1],
    [1,1,1,1],
    [1,1,1,1],
],[
    [0,0,0,0],	//index 12: character {full dark}
    [0,0,0,0],
    [0,0,0,0],
    [0,0,0,0],
    [0,0,0,0],
    [0,0,0,0],
]
];
