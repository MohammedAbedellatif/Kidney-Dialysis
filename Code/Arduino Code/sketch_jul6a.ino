#include <Stepper.h>

const int stepsPerRevolution = 200;

Stepper myStepper1(stepsPerRevolution, A3, A5, A4, A2);
Stepper myStepper2(stepsPerRevolution, A0, 4, 3, 1);

const int buttonPin = 11;
const int PUMP_relay1 = 0;
const int First_VALVE = 13;
const int second_VALVE = 12;
const int Third_VALVE = 10;
const int PUMP_relay2 = 9;
const int heatter_valve = 8;
const int HETTER_relay = A1;
const int forth_VALVE = 7;
const int dy_valve = 6;
const int FIFth_VALVE = 5;
const int ir_valve = 2;
int buttonState = 0;

void setup() {
  pinMode(PUMP_relay1, OUTPUT);
  pinMode(First_VALVE, OUTPUT);
  pinMode(second_VALVE, OUTPUT);
  pinMode(Third_VALVE, OUTPUT);
  pinMode(PUMP_relay2, OUTPUT);
  pinMode(heatter_valve, OUTPUT);
  pinMode(HETTER_relay, OUTPUT);
  pinMode(forth_VALVE, OUTPUT);
  pinMode(dy_valve, OUTPUT);
  pinMode(FIFth_VALVE, OUTPUT);
  pinMode(ir_valve, OUTPUT);

  pinMode(buttonPin, INPUT);
  myStepper1.setSpeed(100);
  myStepper2.setSpeed(100);
}

void loop() {
  buttonState = digitalRead(buttonPin);
  //First Stepper
  if (buttonState == 1) {
    digitalWrite(HETTER_relay, HIGH);
    digitalWrite(PUMP_relay1, HIGH);
    digitalWrite(First_VALVE, HIGH);
    delay(10000);
    digitalWrite(PUMP_relay1, LOW);
    digitalWrite(First_VALVE, LOW);
    delay(60000);
    digitalWrite(PUMP_relay1, HIGH);
    digitalWrite(second_VALVE, HIGH);
    //Stepper1 code
    for (int i = 0; i < 10; i++) {
      myStepper1.step(stepsPerRevolution);
      delay(5);
    }
    myStepper1.step(0);
    delay(100);
    digitalWrite(PUMP_relay1, LOW);
    digitalWrite(second_VALVE, LOW);
    delay(1000);

    //Open Third valve and turning on pump for 20s
    //PUMP OUTPUT Will go to Heatter
    digitalWrite(Third_VALVE, HIGH);
    digitalWrite(heatter_valve, HIGH);
    digitalWrite(PUMP_relay2, HIGH);
    delay(20000);
    digitalWrite(Third_VALVE, LOW);
    digitalWrite(heatter_valve, LOW);
    digitalWrite(PUMP_relay2, LOW);
    delay(1000);

    //Start heating Water
    
    while (true) {
      int sensorValue = analogRead(A6);
      float C = (sensorValue * 4.882);
      float temp2 = (C / 10);
      if (temp2 >= 37) {
        //digitalWrite(HETTER_relay, LOW);
        break;
      } else {
        digitalWrite(HETTER_relay, HIGH);
      }
    }
    delay(5000);
    //Stepper2 code
    for (int i = 0; i < 30; i++) {
      myStepper2.step(stepsPerRevolution);
      delay(5);
    }
    myStepper2.step(0);
    delay(100);

    //Open forth valve and turning on pump for 20s
    //PUMP OUTPUT Will go to Dialysis machine
    digitalWrite(forth_VALVE, HIGH);
    digitalWrite(dy_valve, HIGH);
    digitalWrite(PUMP_relay2, HIGH);
    delay(20000);
    digitalWrite(forth_VALVE, LOW);
    digitalWrite(dy_valve, LOW);
    digitalWrite(PUMP_relay2, LOW);
    delay(1000);

    //Open FIFth valve and turning on pump for 20s
    //PUMP OUTPUT Will go to Ir-sensor
    digitalWrite(FIFth_VALVE, HIGH);
    digitalWrite(ir_valve, HIGH);
    digitalWrite(PUMP_relay2, HIGH);
    delay(20000);
    digitalWrite(FIFth_VALVE, LOW);
    digitalWrite(ir_valve, LOW);
    digitalWrite(PUMP_relay2, LOW);
    delay(1000);
  }
}