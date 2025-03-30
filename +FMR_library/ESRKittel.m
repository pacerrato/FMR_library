function y = ESRKittel(x, gyroRatio, magSusc)
%ESRKITTEL Kittel equation for electron spin resonance  in thin films
%   Arguments must be numerical and have the following meaning:
%       gyroRatio            % Gyromagnetic ratio
%       magSusc              % Magnetic susceptibility
%
%   The fit model is
%   y = gyroRatio * sqrt(1 + magSusc) * |x|

    y = gyroRatio * sqrt(1 + magSusc) * abs(x);
end

