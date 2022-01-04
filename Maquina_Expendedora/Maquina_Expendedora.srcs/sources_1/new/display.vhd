​library​ IEEE; 
 ​use​ IEEE.STD_LOGIC_1164.​ALL​; 
 ​use​ IEEE.numeric_std.​all​; 
  
 ​entity​ ​bcd_7segment   is 
 ​Port​ ( 
 ​    SW1 : ​in​ ​STD_LOGIC_VECTOR​ (​3​ ​downto​ ​0​); 
 ​    SW2 : ​in​ ​STD_LOGIC_VECTOR​ (​3​ ​downto​ ​0​); 
 ​    dinero : ​in​ ​STD_LOGIC_VECTOR​ (​9​ ​downto​ ​0​); 
 ​    Seven_Segment : ​out​ ​STD_LOGIC_VECTOR​ (​12​ ​downto​ ​0​--​D8 D7 D3 DP D2 D1 gfedcba 
      
 ​);  
 ​end​ ​bcd_7segment​; 
  
 ​architecture​ ​Behavioral​ ​of​ ​bcd_7segment​ ​is 
  
 ​begin 
  
 ​process​(SW1,SW2,dinero) 
 
 Seven_Segment ​<=​ ​"-----1000001"​;
 Seven_Segment  <=   "---11-------" 
 
 ​    ​variable​ dinero_i : ​unsigned​; 
 ​begin 
 ​    dinero_i ​:=​ ​unsigned​(dinero); 
 
 ​case​ SW1 ​is 
 ​    ​when​ ​"0000"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0000001"​;  ​--​0 
 ​    ​when​ ​"0001"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----1001111"​;  ​--​1 
 ​    ​when​ ​"0010"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0010010"​;  ​--​2 
 ​    ​when​ ​"0011"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0000110"​;  ​--​3 
 ​    ​when​ ​"0100"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----1001100"​;  ​--​4 
 ​    ​when​ ​"0101"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0100100"​;  ​--​5 
 ​    ​when​ ​"0110"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0100000"​;  ​--​6 
 ​    ​when​ ​"0111"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0001111"​;  ​--​7 
 ​    ​when​ ​"1000"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0000000"​;  ​--​8 
 ​    ​when​ ​"1001"​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----0000100"​;  ​--​9 
 ​    ​when​ ​others​ ​=> 
 ​    Seven_Segment ​<=​ ​"-1----1111110"​;  
 ​end​ ​case​; 
  
 ​case​ SW2 ​is 
 ​    ​when​ ​"0000"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0000001"​;  ​--​0 
 ​    ​when​ ​"0001"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----1001111"​;  ​--​1 
 ​    ​when​ ​"0010"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0010010"​;  ​--​2 
 ​    ​when​ ​"0011"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0000110"​;  ​--​3 
 ​    ​when​ ​"0100"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----1001100"​;  ​--​4 
 ​    ​when​ ​"0101"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0100100"​;  ​--​5 
 ​    ​when​ ​"0110"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0100000"​;  ​--​6 
 ​    ​when​ ​"0111"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0001111"​;  ​--​7 
 ​    ​when​ ​"1000"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0000000"​;  ​--​8 
 ​    ​when​ ​"1001"​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----0000100"​;  ​--​9 
 ​    ​when​ ​others​ ​=> 
 ​    Seven_Segment ​<=​ ​"1-----1111110"​;  
 ​    ​end​ ​case​; 
  
 ​case​ dinero_i ​is 
 ​    ​when​ ​"-0-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0000001"​;  ​--​0 
 ​    ​when​ ​"​-1-​"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-1001111"​;  ​--​1 
 ​    ​when​ ​"-2-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0010010"​;  ​--​2 
 ​    ​when​ ​"-3-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0000110"​;  ​--​3 
 ​    ​when​ ​"-4-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-1001100"​;  ​--​4 
 ​    ​when​ ​"-5-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0100100"​;  ​--​5 
 ​    ​when​ ​"-6-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0100000"​;  ​--​6 
 ​    ​when​ ​"-7-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0001111"​;  ​--​7 
 ​    ​when​ ​"-8-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0000000"​;  ​--​8 
 ​    ​when​ ​"-9-"​ ​=> 
 ​    Seven_Segment ​<=​ ​"----1-0000100"​;  ​--​9 
 
     ​when​ ​"0--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0000001"​;  ​--​0 
 ​    ​when​ ​"​1--​"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--1001111"​;  ​--​1 
 ​    ​when​ ​"2--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0010010"​;  ​--​2 
 ​    ​when​ ​"3--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0000110"​;  ​--​3 
 ​    ​when​ ​"4--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--1001100"​;  ​--​4 
 ​    ​when​ ​"5--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0100100"​;  ​--​5 
 ​    ​when​ ​"6--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0100000"​;  ​--​6 
 ​    ​when​ ​"7--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0001111"​;  ​--​7 
 ​    ​when​ ​"8--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0000000"​;  ​--​8 
 ​    ​when​ ​"9--"​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--0000100"​;  ​--​9 
 ​    ​when​ ​others​ ​=> 
 ​    Seven_Segment ​<=​ ​"---1--1111110"​;  
 ​    ​end​ ​case​; 
  
 ​end​ ​process​; 
  
 ​end​ ​Behavioral​;