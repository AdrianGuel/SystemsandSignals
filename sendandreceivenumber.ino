// Declare variables
int rawSensorVal;
String incomingString;
float aux;

void setup(){
  // Initialize serial port
  Serial.begin(9600);
  Serial.setTimeout(3);
}

void loop(){
  // Read analog pin
  //rawSensorVal = analogRead(A0);
  // Check if MATLAB has sent a character
  if (Serial.available() > 0) {
    incomingString = Serial.readString();
    aux=incomingString.toFloat();
    delay(100);
    // If character is correct send MATLAB the analog value
    //if (incomingString == "a\n") {
      Serial.println(aux);
    //}
  }
}
