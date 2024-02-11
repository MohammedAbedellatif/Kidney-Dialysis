sbit LCD_RS at RD1_bit;
sbit LCD_EN at RD2_bit;
sbit LCD_D7 at RC6_bit;
sbit LCD_D6 at RC5_bit;
sbit LCD_D5 at RC4_bit;
sbit LCD_D4 at RD4_bit;

sbit LCD_RS_Direction at TRISD1_bit;
sbit LCD_EN_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISC6_bit;
sbit LCD_D6_Direction at TRISC5_bit;
sbit LCD_D5_Direction at TRISC4_bit;
sbit LCD_D4_Direction at TRISD4_bit;

char txt[16];
float volt;
float CT, temp;
int time = 0;
void main(){
    TRISB = 0b11000000;
    PORTB = 0;
    TRISC = 0;
    PORTC = 0;
    TRISD = 0; // Define D as output
    PORTD = 0;
    Lcd_Init(); // Initialize LCD screen
    Lcd_Cmd(_LCD_CLEAR); // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
    Lcd_Out(1, 1, "Processing..."); // Write text in the first row
    Delay_ms(1000); // Wait for 1 second
    Lcd_Cmd(_LCD_CLEAR); // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
    while(1){
        volt = ADC_Read(0);
        CT = volt * 4.882;
        temp = CT / 10;
        Lcd_Out(1, 1, "Temp: ");
        FloatToStr(temp, txt);
        Lcd_Out(1, 7, txt);
        Lcd_Out(1, 15, "C");
        portb.f6 = (time%2==1) ? 1: 0;
        portb.f7 = (time%2==1) ? 1: 0;
        if(portb.f6 == 1 && portb.f7 == 1 && temp < 37){
            portb.f1 = 1; // Open the heater
            portb.f2 = 1; // Open the heater
        }else{
            portb.f1 = 0; // Close the heater
            portb.f2 = 0; // Close the heater
        }
    }
        // Wait for 1 second
        Delay_ms(100);
}