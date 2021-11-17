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
theta=0:0.1:2*pi;
k=1;
while (toc < startTimer+5)
  % Send float and receive float
  fprintf(s, theta(k));
  k=k+1;
  out = fscanf(s, '%f\n');
  % Display data to user
  fprintf("%f\n",out)
  %pause(0.1);
  % Increment counter
  count = count + 1;
  if k==length(theta)
      k=1;
  end
end
% Display sample rate to user
endTimer = toc;
fprintf("Sample rate was: %0.2f Hz\n",count/(endTimer - startTimer))
% Remove serial port connection
fclose(s);
delete(s)
clear s
