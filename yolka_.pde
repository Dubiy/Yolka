//Пин подключен к ST_CP входу 74HC595
int latchPin = 8;
//Пин подключен к SH_CP входу 74HC595
int clockPin = 12;
//Пин подключен к DS входу 74HC595
int dataPin = 11;
 
int Rpin = 3;
int Gpin = 5;
int Bpin = 6;

int RGBmaxPover = 40;
 
int skiper = 0; 
 
void setup() {
  //устанавливаем режим OUTPUT
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  
  
  pinMode(Rpin, OUTPUT);
  pinMode(Gpin, OUTPUT);
  pinMode(Bpin, OUTPUT);  

  
}
 
void loop() {
  // отсчитываем от 0 до 255  и отображаем значение на светодиоде
  for (int numberToDisplay = 0; numberToDisplay < 256; numberToDisplay++) {
    // устанавливаем синхронизацию "защелки" на LOW
    digitalWrite(latchPin, LOW);
    // передаем отсчет для вывода на зеленые светодиоды
    shiftOut(dataPin, clockPin, MSBFIRST, numberToDisplay); 
    // передаем обратный отсчет  для вывода на красные светодиоды
    shiftOut(dataPin, clockPin, MSBFIRST, 255-numberToDisplay);
    //"защелкиваем" регистр, тем самым устанавливая значения на выходах
    digitalWrite(latchPin, HIGH);
    // пауза перед следующей итерацией
    skiper++;
    if (skiper == 10) {
      analogWrite(Rpin, random(RGBmaxPover) + 255 - RGBmaxPover);
      analogWrite(Gpin, random(RGBmaxPover) + 255 - RGBmaxPover);
      analogWrite(Bpin, random(RGBmaxPover) + 255 - RGBmaxPover);
      skiper = 0;
    }
    
    delay(100);
    

    
    
  }
}
