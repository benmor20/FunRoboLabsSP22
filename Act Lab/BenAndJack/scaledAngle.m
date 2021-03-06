function scaleFunc = scaledAngle(filepath)
% Given a filepath of servo position to angle data, create a function that
% will map desired angle to target position
    servoData = load(filepath);
    coefs = polyfit(servoData(:, 1), servoData(:, 2), 1);
    scaleFunc = @(angle) max(min(angle * coefs(1) + coefs(2), 1), 0);
end