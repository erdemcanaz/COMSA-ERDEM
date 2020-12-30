

Data_UNIT_GRAPH_FORMATTED_V0 = [0 0.08532439 0.11947282 0.13654703 0.17313462 0.20972224 0.23167479 0.25362736 0.29021496 0.31948504 0.34631592 0.37314683 0.39753857 0.40973443 0.43656534 0.46339625 0.48047045 0.49754468 0.52193636 0.53169304 0.5536456 0.5780374 0.5926724 0.614625 0.6341383 0.65609086 0.66828674 0.69511765 0.7097527 0.72194856 0.7365836 0.7487795 0.75853616 0.77292734 0.7851232 0.7924407 0.80707574 0.81683207 0.824149 0.8387829 0.8509779 0.86073387 0.86805075 0.88024575 0.8900017 0.9021966 0.91195256 0.91926956 0.92414755 0.9290255 0.93390346 0.9412204 0.9485374 0.9558543 0.9631713 0.97048825 0.97780526 0.98024416 0.9826832 0.98756117 0.9900001 0.99243915 0.99731714 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.99731714 0.99731714 0.9948781 0.99243915 0.98756117 0.98512214 0.9826832 0.97780526 0.9729273 0.9680493 0.9631713 0.9607323 0.9509763 0.9436594 0.93878144 0.9290255 0.92170846 0.9095136 0.8948797 0.8851237 0.86805075 0.8509779 0.836344 0.81683207 0.8021974 0.782684 0.7487795 0.7341444 300 59 ];

FLOW = 5; 
efficiency_at_FLOW=getVerticalValue_UGF0( Data_UNIT_GRAPH_FORMATTED_V0, FLOW )

function f1 = getVerticalValue_UGF0(DATA, input_horizontal_value)
    %% 102 entry, 101-> horizontal max, 102-> vertical max, 'E' if no vertical data exists
  
    %%ERRORS
    if(input_horizontal_value<0) %1
        error("FUNCTION: getVerticalValue_UGF0(..) ERROR1: input horizontal value  is negative" ); 
    end
    if(length(DATA)~= 102)%2
        error("FUNCTION: getVerticalValue_UGF0(..) ERROR2: number of elements is not 102" ); 
    end   
    if(DATA(101) == 0 || DATA(102)==0 ) %3
        error("FUNCTION: getVerticalValue_UGF0(..) ERROR3: Maximum value(s) of the data is zero" ); 
    end    
    if(DATA(101) < 0 || DATA(102)< 0 ) %4
        error("FUNCTION: getVerticalValue_UGF0(..) ERROR4: Maximum value(s) of the data is negative" ); 
    end
    if(DATA(101)< input_horizontal_value) %5
        error("FUNCTION: getVerticalValue_UGF0(..) ERROR5: input horizontal value  is greater than the limit" ); 
    end
    for index = 1:1:100 %6
     if(DATA(index) =='E')
         continue
     elseif(DATA(index)>1 || DATA(index)<0)
         error("FUNCTION: getVerticalValue_UGF0(..) ERROR6: corrupted vertical value. 0<= val <= 1 is not satisfied" ); 
     end
    end
    
    %%%%%%%% 
    
    %%index_corresponds_to_input € [1,100], float
    index_corresponds_to_input= 1 + 99*(input_horizontal_value/DATA(101));   
    %%lower_index € [1,100], integer
    lower_index = floor(index_corresponds_to_input);
    %%upper_index € [1,100], integer
    upper_index = ceil(index_corresponds_to_input);
    
    %%linear approximation
    if( isnumeric(DATA(lower_index)) && isnumeric(DATA(upper_index)) )
        dy = DATA(102)*( DATA(upper_index)-DATA(lower_index) );
        dx = mod(index_corresponds_to_input,1);
        f1 = DATA(102)*DATA(lower_index)+ dy*dx;
    elseif(isnumeric(DATA(lower_index)) && ~isnumeric(DATA(upper_index)))
        f1 = DATA(102)*DATA(lower_index);
    elseif(~isnumeric(DATA(lower_index)) && isnumeric(DATA(upper_index)))
        f1 = DATA(102)*DATA(upper_index);
    elseif(~isnumeric(DATA(lower_index)) && ~isnumeric(DATA(upper_index)))
        f1 = 'E';
    end 
    
 
end













