
_main:

;PICcode.c,19 :: 		void main(){
;PICcode.c,20 :: 		TRISB = 0b11000000;
	MOVLW      192
	MOVWF      TRISB+0
;PICcode.c,21 :: 		PORTB = 0;
	CLRF       PORTB+0
;PICcode.c,22 :: 		TRISC = 0;
	CLRF       TRISC+0
;PICcode.c,23 :: 		PORTC = 0;
	CLRF       PORTC+0
;PICcode.c,24 :: 		TRISD = 0; // Define D as output
	CLRF       TRISD+0
;PICcode.c,25 :: 		PORTD = 0;
	CLRF       PORTD+0
;PICcode.c,26 :: 		Lcd_Init(); // Initialize LCD screen
	CALL       _Lcd_Init+0
;PICcode.c,27 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PICcode.c,28 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PICcode.c,29 :: 		Lcd_Out(1, 1, "Processing..."); // Write text in the first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_PICcode+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PICcode.c,30 :: 		Delay_ms(1000); // Wait for 1 second
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;PICcode.c,31 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PICcode.c,32 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PICcode.c,33 :: 		while(1){
L_main1:
;PICcode.c,34 :: 		volt = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _volt+0
	MOVF       R0+1, 0
	MOVWF      _volt+1
	MOVF       R0+2, 0
	MOVWF      _volt+2
	MOVF       R0+3, 0
	MOVWF      _volt+3
;PICcode.c,35 :: 		CT = volt * 4.882;
	MOVLW      88
	MOVWF      R4+0
	MOVLW      57
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _CT+0
	MOVF       R0+1, 0
	MOVWF      _CT+1
	MOVF       R0+2, 0
	MOVWF      _CT+2
	MOVF       R0+3, 0
	MOVWF      _CT+3
;PICcode.c,36 :: 		temp = CT / 10;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+2, 0
	MOVWF      _temp+2
	MOVF       R0+3, 0
	MOVWF      _temp+3
;PICcode.c,37 :: 		Lcd_Out(1, 1, "Temp: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_PICcode+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PICcode.c,38 :: 		FloatToStr(temp, txt);
	MOVF       _temp+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _temp+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _temp+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _temp+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;PICcode.c,39 :: 		Lcd_Out(1, 7, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PICcode.c,40 :: 		Lcd_Out(1, 15, "C");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_PICcode+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PICcode.c,41 :: 		portb.f6 = (time%2==1) ? 1: 0;
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _time+0, 0
	MOVWF      R0+0
	MOVF       _time+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      1
	XORWF      R0+0, 0
L__main14:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
	MOVLW      1
	MOVWF      ?FLOC___mainT11+0
	GOTO       L_main4
L_main3:
	CLRF       ?FLOC___mainT11+0
L_main4:
	BTFSC      ?FLOC___mainT11+0, 0
	GOTO       L__main15
	BCF        PORTB+0, 6
	GOTO       L__main16
L__main15:
	BSF        PORTB+0, 6
L__main16:
;PICcode.c,42 :: 		portb.f7 = (time%2==1) ? 1: 0;
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _time+0, 0
	MOVWF      R0+0
	MOVF       _time+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      1
	XORWF      R0+0, 0
L__main17:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	MOVLW      1
	MOVWF      ?FLOC___mainT16+0
	GOTO       L_main6
L_main5:
	CLRF       ?FLOC___mainT16+0
L_main6:
	BTFSC      ?FLOC___mainT16+0, 0
	GOTO       L__main18
	BCF        PORTB+0, 7
	GOTO       L__main19
L__main18:
	BSF        PORTB+0, 7
L__main19:
;PICcode.c,43 :: 		if(portb.f6 == 1 && portb.f7 == 1 && temp < 37){
	BTFSS      PORTB+0, 6
	GOTO       L_main9
	BTFSS      PORTB+0, 7
	GOTO       L_main9
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      20
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
L__main12:
;PICcode.c,44 :: 		portb.f1 = 1; // Open the heater
	BSF        PORTB+0, 1
;PICcode.c,45 :: 		portb.f2 = 1; // Open the heater
	BSF        PORTB+0, 2
;PICcode.c,46 :: 		}else{
	GOTO       L_main10
L_main9:
;PICcode.c,47 :: 		portb.f1 = 0; // Close the heater
	BCF        PORTB+0, 1
;PICcode.c,48 :: 		portb.f2 = 0; // Close the heater
	BCF        PORTB+0, 2
;PICcode.c,49 :: 		}
L_main10:
;PICcode.c,50 :: 		}
	GOTO       L_main1
;PICcode.c,52 :: 		Delay_ms(100);
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;PICcode.c,53 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
