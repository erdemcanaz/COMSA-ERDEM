%%%THE SYSTEM:
PUMP_POWER = 5500; %watt, no VFD
ELEVATION = 50; %m -> between pump and water tank
MIN_ALLOWED_FLOW = 0; %m3/s
MAX_ALLOWED_FLOW = 0.005; %m3/s
PIPE_ROUGHNESS = 140; %(https://www.engineeringtoolbox.com/hazen-williams-coefficients-d_798.html )
PIPE_INNER_DIAMETER = 0.020; % m
PIPE_LENGTH = 260; % m 
PIPE_COST_PER_METER_TL = 2.35;   % https://www.boruburada.com/polietilen-boru: 
PUMP_COST_TL = 14500; 

DATASHEET_MAX_FLOW_GIVEN = 0.005;
%%% PUMP CHARACTERISTICS
HEAD_FLOW_CHARACTERISTIC_LperMinute_250_300_RAW = [0.6909492 0.68874156 0.6865339 0.6843263 0.68211865 0.679911 0.6777034 0.67549574 0.67108047 0.66887283 0.6666652 0.66445756 0.6622499 0.6600423 0.655627 0.655627 0.6512117 0.6467964 0.64238113 0.6401735 0.6357582 0.6335506 0.6291353 0.6269277 0.62030476 0.6180971 0.6136818 0.6092665 0.60485125 0.6026436 0.59822834 0.59381306 0.5893978 0.5849825 0.57835954 0.5761519 0.57173663 0.5651137 0.5629061 0.5562831 0.5496602 0.54524493 0.54082966 0.53420675 0.5297915 0.5253762 0.52096087 0.51433796 0.5099227 0.5032998 0.49667686 0.49226156 0.48563865 0.47901574 0.47460043 0.46797752 0.4613546 0.45473173 0.4481088 0.44148588 0.4370706 0.43044767 0.42382476 0.41720185 0.41278654 0.40174836 0.39512542 0.39071015 0.38408723 0.37525666 0.37084138 0.36421847 0.3553879 0.348765 0.33993444 0.3333115 0.3266886 0.32006568 0.3112351 0.30240455 0.29798925 0.28695107 0.2781205 0.2737052 0.26487467 0.2560441 0.24942118 0.24059062 0.23396769 0.22513713 0.21630657 0.207476 0.2008531 0.19202253 0.18319197 0.17436141 0.16773848 0.15890792 0.14566208 0.14345445 ];
HEAD_FLOW_CHARACTERISTIC_MCubePerSecond_250_0005 = HEAD_FLOW_CHARACTERISTIC_LperMinute_250_300_RAW*250;

EFFICIENCY_FLOW_CHARACTERISTIC_LperMinute_59_300_RAW = [0 0.08532439 0.11947282 0.13654703 0.17313462 0.20972224 0.23167479 0.25362736 0.29021496 0.31948504 0.34631592 0.37314683 0.39753857 0.40973443 0.43656534 0.46339625 0.48047045 0.49754468 0.52193636 0.53169304 0.5536456 0.5780374 0.5926724 0.614625 0.6341383 0.65609086 0.66828674 0.69511765 0.7097527 0.72194856 0.7365836 0.7487795 0.75853616 0.77292734 0.7851232 0.7924407 0.80707574 0.81683207 0.824149 0.8387829 0.8509779 0.86073387 0.86805075 0.88024575 0.8900017 0.9021966 0.91195256 0.91926956 0.92414755 0.9290255 0.93390346 0.9412204 0.9485374 0.9558543 0.9631713 0.97048825 0.97780526 0.98024416 0.9826832 0.98756117 0.9900001 0.99243915 0.99731714 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.99731714 0.99731714 0.9948781 0.99243915 0.98756117 0.98512214 0.9826832 0.97780526 0.9729273 0.9680493 0.9631713 0.9607323 0.9509763 0.9436594 0.93878144 0.9290255 0.92170846 0.9095136 0.8948797 0.8851237 0.86805075 0.8509779 0.836344 0.81683207 0.8021974 0.782684 0.7487795 0.7341444 ];
EFFICIENCY_FLOW_CHARACTERISTIC_MCubePerSecond_59_0005 = EFFICIENCY_FLOW_CHARACTERISTIC_LperMinute_59_300_RAW*59;
%%%


result = calculate_operating_point(HEAD_FLOW_CHARACTERISTIC_MCubePerSecond_250_0005,PUMP_POWER,ELEVATION,MIN_ALLOWED_FLOW,MAX_ALLOWED_FLOW,DATASHEET_MAX_FLOW_GIVEN,PIPE_ROUGHNESS,PIPE_INNER_DIAMETER,PIPE_LENGTH,PIPE_COST_PER_METER_TL,PUMP_COST_TL);
    % 1 flow in m3/s : 
    display("Flow in L/s :"+result(1)*1000);
    display("Flow in m3/h :"+result(1)*3600);
    % 2 pump pressure at operating point in water*m
    display("Pump pressure in waterHead :"+result(2));
    % 3 friction loss :
    display("Friction pressure drop in waterHead :"+result(3));
    % 4 elevation
    display("Elevation in meter :"+result(4));
    % 5 pumping power in watts
    display("Pumping power in watts :"+result(5));
    % 6 real efficiency
    display("Pump power in watts :"+PUMP_POWER);
    display("Efficiency in percentage %:"+result(6)*100);
    % 7 pipe cost
    display("Piping cost in TL :"+result(7));
    % 10 pipe diameter 
    display("Pipe inner diameter in m:"+result(10));
    % 8 pump cost
    display("Pump cost in TL :"+result(8));
    % 9 system cost
    display("System cost in TL :"+result(9));
   

    


function f1 = calculate_head_loss_using_flow(flow, roughness ,inner_dia, pipe_length)
    %% HAZEN- WILLIAMS EQUATION %%
    %flow in m^3/s %roughness 0-200 coefficient %inner_dia in m %pipe length in m
    f1 = ( 10.67*power(flow,1.852)*pipe_length )/ ( power(roughness,1.852)*power(inner_dia,4.8704));
    %result in water head ( pressure equivalent of 1 meter of water)
end
function f2 = calculate_operating_point(PUMP_HEAD_FLOW_CHR,PUMP_POWER,elevation, min_flow ,max_flow, PUMP_MAX_FLOW, roughness, inner_dia, pipe_length,pipe_cost_per_meter,pump_cost)
    avg_flow = (min_flow + max_flow) /2;
    drop=0;
    pump_pressure=0;
    for i=0 : 1 : 7       
        drop = calculate_head_loss_using_flow(avg_flow,roughness, inner_dia,pipe_length);
        required_pressure = elevation+ drop; 
      
        pump_pressure =  PUMP_HEAD_FLOW_CHR( round((100*avg_flow)/PUMP_MAX_FLOW) );  
        
        
        if(pump_pressure<required_pressure)%shift point to the left
            max_flow=avg_flow;
        elseif (pump_pressure>required_pressure)%shift point to the right
            min_flow=avg_flow ;   
        end
        avg_flow = (min_flow + max_flow) /2;
       
    end
    
    pumping_power = avg_flow *1000*9.8*elevation;
    real_efficiency = pumping_power/PUMP_POWER;    
    pipe_cost= pipe_cost_per_meter * pipe_length;
    system_cost = pipe_cost+pump_cost;
    % 1 flow in m3/s :  
    % 2 pump pressure at operating point in water*m
    % 3 friction loss :
    % 4 elevation
    % 5 pumping power in watts
    % 6 real efficiency
    % 7 pipe cost
    % 8 pump cost
    % 9 system cost
    f2=[ avg_flow pump_pressure drop elevation pumping_power real_efficiency pipe_cost pump_cost system_cost inner_dia ];

end












