ft2m = 0.3048
slugs2kg = 14.5939
kg_m2_2_slugsft2 = 0.7375621419

m_aircraft = 9295
l_aircraft = 15.06
wingspan = 9.144
wing_area = 28
wing_width = 9.96
m_load = 1000  #Kg
r_load = 0.3
n = 4
wing_mass = 0.12 * m_aircraft # % this is the combined mass of both wings
r_fuselage = 1.5
wingspan_new = wingspan - r_fuselage *  2
m_sym = m_aircraft + n * m_load
m_asym = m_aircraft + (n-1) * m_load
c_bar = 11.32*ft2m
#m_aircraft_prime = m_aircraft - m_load; % KR

I_fuselage_origin = 0.5 * (m_aircraft - wing_mass) * (r_fuselage)**2
I_wings = 2 * (1/12) * (wing_mass) * (2 * (wing_width)**2)
I_load = n * ((0.5 * m_load * (r_load)**2) + (m_load * (wing_width)**2))
I_load_drop = (0.5 * m_load * (r_load)**2) + (m_load )* ((wing_width)**2) # KR
pat_factor = (m_load * (wing_width)**2)  # KR



# I_sym = I_fuselage_origin + I_wings + I_load
Ixx = 9496.0 * 14.5939 * (ft2m**2)         #  % Principle Moment of Intertia around X-axis, slugs*ft^2
Iyy = 55814.0 * 14.5939 * (ft2m**2)         # % Principle Moment of Intertia around Y-axis, slugs*ft^2
Izz = 63100.0 * 14.5939 * (ft2m**2)
Ixx_sym = Ixx + I_load                     # KR
Iyy_sym = Iyy + I_load - (n * pat_factor)  # KR
Izz_sym = Izz + I_load - (n * pat_factor)  # KR

cg_x_sym = 0
cg_y_sym = 0
cg_z_sym = 0
cg_shift = (m_aircraft * 0 + (n/2)*m_load - (n/2-1)*m_load)/m_asym
g = 9.81000


print(f"cg_shift = {cg_shift}")


# ---------------------------------------------------------------------------------------------------#
# Ixx = 9496.0 * 14.5939          #  % Principle Moment of Intertia around X-axis, slugs*ft^2
# Iyy = 55814.0 * 14.5939          # % Principle Moment of Intertia around Y-axis, slugs*ft^2
# Izz = 63100.0 * 14.5939 
# ----------------------------------------------------------------------------------------------------#
print(f"I_load_drop = {I_load_drop*kg_m2_2_slugsft2}")
print(f"Ixx_sym = {Ixx_sym*kg_m2_2_slugsft2}")  # These moments of inertias have been calculated using the already 
print(f"Iyy_sym = {Iyy_sym*kg_m2_2_slugsft2}")  # given MOIs and adding the MOI of the load. The parallel axis 
print(f"Izz_sym = {Izz_sym*kg_m2_2_slugsft2}")  # theorem has been appiled only for Ixx with the asumption that it 
                               # 0 along the y and z axis. 
print('*************************************************')

#-------------------------------------------------------------------------------------------------------#

Ixx_asym = Ixx_sym - I_load_drop                      # A similar assumption to the one above has been used 
Iyy_asym = Iyy_sym - (0.5 * m_load * (r_load)**2)     # here; the parallel axis theorem has been applied 
Izz_asym = Izz_sym - (0.5 * m_load * (r_load)**2)     # only along the x axis
Ixy_asym = (n-1)*m_load*(0.25*wingspan_new)*(0.05)

#-------------------------------------------------------------------------------------------------------#


print(f"Ixx_asym = {(Ixx_asym*kg_m2_2_slugsft2):.2f}")  
print(f"Iyy_asym = {(Iyy_asym*kg_m2_2_slugsft2):.2f}")  
print(f"Izz_asym = {(Izz_asym*kg_m2_2_slugsft2):.2f}")
print(f"mass_sym_w_load = {m_sym:.2f}")  
print(f"mass_asym = {(m_asym):.2f}")
print(f"Ixy_asym = {(Ixy_asym*kg_m2_2_slugsft2):.2f}")