
arduinoObj = serialport(serialportlist("available")',9600);

configureTerminator(arduinoObj,"CR/LF");

flush(arduinoObj);

arduinoObj.UserData = struct("Data",[],"Count",1);

configureCallback(arduinoObj,"terminator",@readSineWaveData);

function readSineWaveData(src, ~)

% Read the ASCII data from the serialport object.
data = readline(src);

% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
src.UserData.Data(end+1) = str2double(data);

% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;

% If 1001 data points have been collected from the Arduino, switch off the
% callbacks and plot the data.

 
if src.UserData.Count > 1001
     plot(src.UserData.Data(2:end));
    configureCallback(src, "off");  
end
end