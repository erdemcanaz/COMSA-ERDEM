
Q = 0.005; % flow rate in m^3 / s
L = 260; % pipe length in meters
C = 140; % pipe rougness (https://www.engineeringtoolbox.com/hazen-williams-coefficients-d_798.html )
R = 0.060; % inside pipe diameter in meters

flow = linspace(0,Q ,100)
y= calculate_head_loss_using_flow(flow,C,R,L); %% y is in waterHead pressure drop
plot(flow,y);

%pump_head_250_flow_350_chr = [0.68281853 0.68281853 0.6806158 0.6762102 0.6740074 0.67180467 0.66960186 0.6651963 0.66299355 0.66299355 0.658588 0.65638524 0.6519797 0.6475741 0.6453713 0.64096576 0.6365602 0.63215464 0.6299519 0.62554634 0.618938 0.6167352 0.61232966 0.6145325 0.60572135 0.59691024 0.5925047 0.5880991 0.58149076 0.57708526 0.5726797 0.56827414 0.55946296 0.5550574 0.55065185 0.54404354 0.5374352 0.53082687 0.5264213 0.519813 0.51320463 0.5065963 0.499988 0.49337965 0.48677132 0.48016298 0.47355464 0.4669463 0.45813525 0.4515269 0.44491857 0.43610746 0.4317019 0.4228908 0.4140797 0.40967414 0.39866024 0.3920519 0.3854436 0.3744297 0.37002414 0.36121303 0.35019913 0.34579358 0.3347797 0.3237658 0.31936026 0.30834636 0.29953527 0.29292694 0.28191304 0.2753047 0.2642908 0.25327694 0.2466686 0.23565471 0.2268436 0.2180325 0.2070186 0.1982075 0.18939638 0.1783825 0.17177416 0.1585575 0.14974639 0.14534083 0.13432695 0.12551583 0.116704725 0.10569084 0.09687973 0.08806862 0.07925751 0.070446394 0.05943251 0.0506214 0.04181029 0.03520196 0.021985292 0.013174183 ];
%plot(flow,pump_head_250_flow_350_chr*250,flow,y);  %WATER PUMP CHARACTERISTIC



%pressure_loss =  calculate_head_loss_using_flow(Q,C,R,L);
function f1 = calculate_head_loss_using_flow(flow, roughness ,inner_dia, pipe_length)
    f1 = ( 10.67*power(flow,1.852)*pipe_length )/ ( power(roughness,1.852)*power(inner_dia,4.8704));
end
function f1 = calculate_head_loss_using_velocity(velocity, roughness ,inner_dia, pipe_length)
    f1 = ( 10.67*power(flow,1.852)*pipe_length )/ ( power(roughness,1.852)*power(inner_dia,4.8704));
end