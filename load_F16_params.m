% ==========================
% Developed by
% Raktim Bhattacharya, 
% Professor
% Aerospace Engineering,
% Texas A&M University.
% ==========================

function Param = load_F16_params()
% Inertia and geometry data for F16.
% All parameters are in SI Units.

slugs2kg = 14.5939;
ft2m     = 0.3048;

Param.S = 300*ft2m^2;      % Reference Area, m^2
Param.b =  30*ft2m;        % Wing Span, m
Param.cbar =  11.32*ft2m;     % Aerodynamic Mean Chord, m
Param.rho = 1.293;         % Air Density, kg/m^3
Param.xcgr = 0.35;         % reference center of gravity as a fraction of cbar
Param.xcg  = 0.30;         % center of gravity as a fraction of cbar.

% Asymmetric Parameters
%Param.S_asym = ;      % Reference Area, m^2
%Param.b_asym = ;        % Wing Span, m
%Param.cbar_asym = ;     % Aerodynamic Mean Chord, m
%Param.rho_asym = 1.293;         % Air Density, kg/m^3
%Param.xcgr_asym =;         % reference center of gravity as a fraction of cbar
%Param.xcg_asym  =;         % center of gravity as a fraction of cbar.



% Moment of Inertial
% Ixx = 9496.0;            % Principle Moment of Intertia around X-axis, slugs*ft^2
% Iyy = 55814.0;           % Principle Moment of Intertia around Y-axis, slugs*ft^2
% Izz = 63100.0;           % Principle Moment of Intertia around Z-axis, slugs*ft^2 
% Ixz = 982.0;           % Principle Moment of Intertia around XZ-axis,slugs*ft^2

% Moment of Inertial (With Load)
Ixx_w_load = 36698.21;            % Principle Moment of Intertia around X-axis, slugs*ft^2
Iyy_w_load =55826.33 ;           % Principle Moment of Intertia around Y-axis, slugs*ft^2
Izz_w_load = 63112.33;           % Principle Moment of Intertia around Z-axis, slugs*ft^2 
Ixz = 982.0; 

% Moment of Inertial


% Moment of Inertial (Asymmetric)
Ixx_asym = 229097.60 ;         % Principle Moment of Intertia around X-axis, slugs*ft^2
Iyy_asym = 55913.56 ;          % Principle Moment of Intertia around Y-axis, slugs*ft^2
Izz_asym = 63199.56;           % Principle Moment of Intertia around Z-axis, slugs*ft^2 
Ixz_asym = 982.0 ;             % Principle Moment of Intertia around XZ-axis,slugs*ft^2
Ixy_asym = 169.93;             % Principle Moment of Intertia around XY-axis,slugs*ft^2  -> KR     

Ixx = Ixx_asym;         % Principle Moment of Intertia around X-axis, slugs*ft^2
Iyy = Iyy_asym;         % Principle Moment of Intertia around Y-axis, slugs*ft^2
Izz = Izz_asym;         % Principle Moment of Intertia around Z-axis, slugs*ft^2 
Ixz = 982.0;            % Principle Moment of Intertia around XZ-axis,slugs*ft^2
Ixy = Ixy_asym;         % Principle Moment of Intertia around XY-axis,slugs*ft^2


% Param.moi_asym = [Ixx 0 Ixz;
 %            0   Iyy 0
  %           Ixz 0   Izz]*slugs2kg*(ft2m)^2; % Convert to Kg*m^2
Param.mass_asym = 12295.0*slugs2kg ;     % kg

Param.mass_sym = 636.94*slugs2kg;     % kg%
Param.mass_sym_w_load = 13295.0*slugs2kg;
Param.mass = Param.mass_asym;


% Param.moi = [Ixx 0 Ixz;
%              0   Iyy 0
%              Ixz 0   Izz]*slugs2kg*(ft2m)^2; % Convert to Kg*m^2


Param.moi = [Ixx Ixy Ixz;
             Ixy Iyy 0
             Ixz 0   Izz]*slugs2kg*(ft2m)^2; % Convert to Kg*m^2
Param.g = 9.806;  % m/s^2
end