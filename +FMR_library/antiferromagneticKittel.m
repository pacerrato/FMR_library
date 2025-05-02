function y = antiferromagneticKittel(x, gyroRatio, DMField, EAField)
%ANTIFERROMAGNETICKITTEL Kittel equation for antiferromagnetic magnetization in thin films
%   Arguments must be numerical and have the following meaning:
%       gyroRatio            % Gyromagnetic ratio
%       DMField              % Dzyaloshinskii-Moriya field
%       EAField              % Weiss exchange field times anisotropy field
%
%   The fit model is
%   y = gyroRatio * sqrt(x * (x + DMField) + 2 * EAField))

    y = gyroRatio * sqrt(max(0, x .* (x + DMField) + 2 * EAField));
end

