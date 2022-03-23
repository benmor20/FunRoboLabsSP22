function []=RhythmPanTest

%Some code to test how well the pan mechanism returns to a set value from an
%established medium.

%needs to be put into the PositionControlRCServo mlx file to leverage ACT
%function.

%CJ Hilty march 2022. Rev. A.

pp=0.5  %pause between movements
tr=-.2  %test range
while true
ACTRCServoArduino(panServo,tiltServo,min((.775+tr-0.2),1),0.65)
pause(pp)
ACTRCServoArduino(panServo,tiltServo,min((.775+tr),1),0.65)
pause(pp)
ACTRCServoArduino(panServo,tiltServo,min((.775+tr+0.2),1),0.65)
pause(pp)
ACTRCServoArduino(panServo,tiltServo,min((.775+tr),1),0.65)
pause(pp)
end