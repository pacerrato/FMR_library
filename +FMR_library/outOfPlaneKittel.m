function y = outOfPlaneKittel(x, gyroRatio, effMag)
%OUTOFPLANEKITTEL - Kittel equation for out of plane magnetization in thin films
%   Arguments must be numerical and have the following meaning:
%       gyroRatio            % Gyromagnetic ratio
%       effMag               % Effective magnetization
%
%   The fit model is
%   y = gyroRatio * |x - effMag|

    y = gyroRatio * abs(x - effMag);
end

