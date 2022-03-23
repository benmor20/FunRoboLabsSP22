function [] = laser(robotArduino, status)

% Laser is a function that will write the digital pin for the laser to On
% if a true is passed into it and off if a false is passed into it.
% Inputs: robotArduino, status (true or false.)

writeDigitalPin(robotArduino,'D8', status)

end