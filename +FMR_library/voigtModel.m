function y = voigtModel(x, a, lLW, hr, theta, gLW, c0, c1, c2)
    %VOIGTMODEL Voigt function to model resonance peaks
    %   Arguments must be numerical and have the following meaning:
    %       a                    % Peak area
    %       lLW                  % FWHM of the lorentzian
    %       hr                   % Resonance field
    %       theta                % Phase of between lorentzian  
    %       gLW                  % FWHM of the gaussian
    %       c0                   % Background offset
    %       c1                   % Background linear term
    %       c2                   % Background quadratic term
    %
    %   The model is
    %   a * 2*sqrt(log(2)/pi)/gLW * real((cos(theta) + 1i * sin(theta)) * fadf(sqrt(log(2)) * (2*(x-hr) + 1i*lLW) / gLW)) + c0 + c1 * x + c2 * x.^2;

    % if gLW < 1e-5 || gLW < 1e-3 * lLW
    %     y = a / 3.1415927 * (lLW/2 * cos(theta) - (x - hr) * sin(theta)) ./ ...
    %         ((lLW/2)^2 + (x - hr).^2) + c0 + c1 * x + c2 * x.^2;
    % else
        y = a * 0.939437/gLW * real((cos(theta) + 1i * sin(theta)) * ...
                            fadf(0.8325546 * (2*(x-hr) + 1i*lLW) / gLW)) + ...
            c0 + c1 * x + c2 * x.^2;
    % end
end

