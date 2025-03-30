function y = inzzPlaneKittel(x, gyroRatio, effMag, aniField)
%inPlaneKittel Kittel equation for in plane magnetization in thin films
%   Arguments must be numerical and have the following meaning:
%       gyroRatio            % Gyromagnetic ratio
%       effMag               % Effective magnetization
%       aniField             % Anisotropy field
%
%   The fit model is
%   y = gyroRatio * sqrt((x + aniField) * (x + effMag + aniField))

    y = gyroRatio * sqrt(max(0, (x + aniField) .* (x + effMag + aniField)));
end

