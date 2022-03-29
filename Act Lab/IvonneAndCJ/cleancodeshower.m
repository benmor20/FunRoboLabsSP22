
controlFlag = 1;            % create a loop control

while (controlFlag< nMoves+1)   %loop till nMoves have occurred

if demoFlag % Skip all data collection if the demo mode is active
        ACTRCServoArduino(panServo, tiltServo, coordinates(controlFlag,1), coordinates(controlFlag,2));     % Direct DC servomotor to desired position
        laser(robotArduino,coordinates(controlFlag,3));
panServoData=zeros(50)
tiltServoData=zeros(50)
else
    commandValue = SENSE();        
    THINK();  
    ACTdirectServoPosition(panServo, tiltServo, panValue, tiltValue);     

    %store experimental commanded versus actual data
    panServoData(controlFlag, 1) = input('Enter actual pan angle (degrees): ');
    panServoData(controlFlag, 2) = commandValue;
    tiltServoData(controlFlag, 1) = input('Enter actual tilt angle (degrees): ');
    tiltServoData(controlFlag, 2) = commandValue;

    waitfor(r);         %wait for loop cycle to complete
    controlFlag = controlFlag+1; %increment loop

end

%create arduino and arduino-pin ref-objects
[robotArduino, panServo, tiltServo, blinkLED] = SETUPARDUINO('COM8');

% Turn on board LED to signal program has started
    Blink(robotArduino,blinkLED,3);
    disp("Caution, Pan and Titlt Servos Active.");
    laser(robotArduino, 0) % Start with the laser off
    ACTRCServoArduino(panServo, tiltServo, 50, 30); %Start in neutral position


    function [] = ACTRCServoArduino(panServo, tiltServo, pixelX, pixelY)

    % scale desired x-y 'pixel' position on the 100 by 67 backboard
    targetX = 0.91/100*pixelX -0.5; %convert to meter target
    targetY = 0.91/100*pixelY -0.31; %for handling by trigonometry

    % convert target position to pan/tilt angle
    panAngle = atand(targetX/1.69);
    tiltAngle = atand(targetY/1.69);

    % scale desired pan/tilt angle to 0-1 for writeposition Arduino command
    pan = min((1/175.6*panAngle+0.775),1); %command will not send greater than 1
    tilt = min((1/174.2*tiltAngle+0.84),1);

    % scaleComAngle = commandAngle/(deg/sec);
    writePosition(panServo,pan);
    writePosition(tiltServo, tilt);
    
    end

SENSEcollectRoutine()

function [coordinates] = SENSEcollectRoutine()
    nTests = input('Enter number of servo positions, then press RETURN: ');
    coordinates = zeros(nTests,2);
    SizeFlag = 1;
    while (SizeFlag<nTests+1)
        coordinates(SizeFlag,1) = input("Set x location for position " + num2str(SizeFlag) + ":   ");
        coordinates(SizeFlag,2) = input("Set y location for position " + num2str(SizeFlag) + ":   ");
        SizeFlag = SizeFlag+1;
    end

    
end

    