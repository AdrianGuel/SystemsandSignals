% Connect to serial port
s = serial('/dev/ttyACM0', 'BaudRate', 9600);
fopen(s);
pause(3);
fprintf("Connection established\n")
% Start a counter and timer
count = 0;
tic
startTimer = toc;
% Get data for 5 seconds
while (toc < startTimer+5)
  % Send character and receive data
  fprintf(s, 0.1);
  out = fscanf(s, '%f\n');
  % Display data to user
  fprintf("%f\n",out)
  pause(0.1);
  % Increment counter
  count = count + 1;
end
% Display sample rate to user
endTimer = toc;
fprintf("Sample rate was: %0.2f Hz\n",count/(endTimer - startTimer))
% Remove serial port connection
fclose(s);
delete(s)
clear s
