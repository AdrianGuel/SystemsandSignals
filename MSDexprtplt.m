% Connect to serial port
s = serial('/dev/ttyACM1', 'BaudRate', 9600);
fopen(s);
pause(3);
fprintf("Connection established\n")
% Get data for 5 seconds
theta=0:.3:2*pi;
k=1;
%data=[];
time = 0;
data = 0;

%Set up Plot
plotGraph = plot(time,data,'-r' );  % every AnalogRead needs to be on its own Plotgraph
title('MSD experiment','FontSize',15);
xlabel('time (s)','FontSize',15);
ylabel('x(t)','FontSize',15);
%legend('x(t)')
min = 0;                         % set y-min
max = 10;
axis([0 5 min max]);
grid('on');

% Start a counter and timer
count = 0;
tic
startTimer = toc;

while (toc < startTimer+45) %substitute by ishandle(plotGraph) to stop closing the plot
  % Send float and receive float
  fprintf(s, theta(k));
  k=k+1;
  % Increment counter
  count = count + 1;
  data(count) = fscanf(s,'%f\n');
  time(count) = toc; 
  if k==length(theta)
      k=1;
  end
         %This is the magic code 
         %Using plot will slow down the sampling time.. At times to over 20
         %seconds per sample!
         set(plotGraph,'XData',time,'YData',data);
          axis([0 time(count) min max]);
          %Update the graph
          pause(0.001);  
end
% Display sample rate to user
endTimer = toc;
frequency=count/(endTimer - startTimer);

%fprintf("Sample rate was: %0.2f Hz\n",count/(endTimer - startTimer))
% Remove serial port connection
fclose(s);
delete(s);
clear s

%t=0:1/frequency:endTimer;
%scatter(t(1:end-1),data,'k','LineWidth',2)
%ylabel('x(t)'); xlabel('t (s)');
%grid on

%plot and compute the ideal response to the same input
m=1; kx=0.2; b=0.5;
G=tf([1],[m,b,kx]);
t=0:0.1:45;
F=ones(1,length(t));
%w=2*pi/0.65;
%F=10*sin(w*t);
y = lsim(G,F,t);
hold on
plot(t,y,'b','LineWidth',2)
