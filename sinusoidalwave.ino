// Declare variables
String incomingString;
float dato;
float y;

void setup(){
  // Initialize serial port
  Serial.begin(9600);
  Serial.setTimeout(3);
}

void loop(){
  if (Serial.available() > 0) {
    incomingString = Serial.readString();
    dato=incomingString.toFloat(); 
    y=10*sin(dato); 
    Serial.println(y);
  }
}
