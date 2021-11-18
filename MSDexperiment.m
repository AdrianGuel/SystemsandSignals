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
theta=0:.3:2*pi;
k=1;
data=[];
while (toc < startTimer+5)
  % Send float and receive float
  fprintf(s, theta(k));
  k=k+1;
  %pause(0.1);
  data(count+1) = fscanf(s, '%f\n');
  % Display data to user
  %fprintf("%f\n",out)
  %
  % Increment counter
  count = count + 1;
  if k==length(theta)
      k=1;
  end
end
% Display sample rate to user
endTimer = toc;
frequency=count/(endTimer - startTimer);
t=0:1/frequency:endTimer;
%fprintf("Sample rate was: %0.2f Hz\n",count/(endTimer - startTimer))
% Remove serial port connection
fclose(s);
delete(s)
clear s

scatter(t(1:end-1),data,'k','LineWidth',2)
ylabel('x(t)'); xlabel('t (s)');
grid on
m=1; kx=0.1; b=1;
G=tf([1],[m,b,kx]);
t=0:0.0311:5;
w=2*pi/0.933;
F=10*sin(w*t);
y = lsim(G,F,t);
hold
plot(t,y,'b','LineWidth',2)
