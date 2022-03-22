function [] = ACTRCServoArduino(panServo, tiltServo, pixelX, pixelY)
% This is an example of  afunction to control a RoboCLaw DC motor
% controller in open-loop, velocity servo mode
% Need to run SEUPARDUINO function first to create arduino and
% velocity servo objects.
% hook Arduino PM pin 9 into Roboclaw digital input 51, hook Arduino ground
% to RoboClawSI Ground.

% Input: Desired velocity (scale 0-1)
% Output: moves servo motor shaft.
% Ivonne and CJ March 2022
    % scale desired x-y 'pixel' position on the 100 by 67 backboard
    targetX = 0.91/100*pixelX -0.5; %convert to meter target
    targetY = 0.91/100*pixelY -0.31; %for handling by trigonometry

    % convert target position to pan/tilt angle
    panAngle = atand(targetX/1.69);
    tiltAngle = atand(targetY/1.69);

    % scale desired pan/tilt angle to 0-1 for writeposition Arduino command
    pan = min((1/175.6*panAngle+0.775),1);
    tilt = min((1/174.2*tiltAngle+0.84),1);

    % scaleComAngle = commandAngle/(deg/sec);
    writePosition(panServo,pan);
    writePosition(tiltServo, tilt);
end