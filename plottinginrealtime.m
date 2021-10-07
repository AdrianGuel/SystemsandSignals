
clear
clc
%User Defined Properties 
a = arduino();             % define the Arduino Communication port

plotTitle = 'Arduino Data Log';  % plot title
xLabel = 'Tiempo (seg)';     % x-axis label
yLabel = 'Voltaje (V)';      % y-axis label
legend1 = 'Sensor 1';
yMax  = 5 ;                          %y Maximum Value
yMin  = 0 ;                      %y minimum Value
plotGrid = 'on';                 % 'off' to turn off grid
min = 0;                         % set y-min
max = 5;                        % set y-max
delay = .01;                     % make sure sample faster than resolution 
%Define Function Variables

time = 0;
data = 0;
count = 0;

%Set up Plot
plotGraph = plot(time,data,'-r' );  % every AnalogRead needs to be on its own Plotgraph
title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1)

axis([yMin yMax min max]);
grid(plotGrid);
tic

while ishandle(plotGraph) %Loop when Plot is Active will run until plot is closed
         dat = readVoltage(a,'A4'); %Data from the arduino     
         count = count + 1;    
         time(count) = toc;    
         data(count) = dat;         
         %This is the magic code 
         %Using plot will slow down the sampling time.. At times to over 20
         %seconds per sample!
         set(plotGraph,'XData',time,'YData',data);
          axis([0 time(count) min max]);
          %Update the graph
          pause(delay);
  end
delete(a);
disp('Plot Closed and arduino object has been deleted');
