%getting different params from the fooof group data
%created by Srishty in october 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INPUT
%fg   : fooof structure containing the parameters
%psds : power spectral density SHOULD be of size Freq x No. Of Cases

%OUTPUT
%aperiodic params : offset,knee (if asked), exponent
%peak params      : CF (central frequency), PW(Power above aperiodic mode),
%           BW(bandwidth)
%err              :error
%r_sq             :r_squared
function [exponent,offset,knee,CF,PH,BW,err,r_sq] = fooof_get_params(fg,psds,settings)
    %if ~exist('settings.aperiodic_mode','var') ||  settings.aperiodic_mode=='fixed'
    if ~any(ismember(fields(settings),'aperiodic_mode'))  
         Fap = 0; %fixed aperiodic mode
         knee = nan;
    elseif settings.aperiodic_mode == 'knee'
        Fap = 1; %knee aperiodic mode
    elseif settings.aperiodic_mode=='fixed'
        Fap=0;%fixed aperiodic mode
         knee = nan;
    end
    
    SZ = size(psds,2);
   % CF = zeros(1,SZ); PH = zeros(1,SZ); BW= zeros(1,SZ);
    for i = 1:SZ
        offset(i) = fg(i).aperiodic_params(1);
        if Fap==1
            knee(i) = fg(i).aperiodic_params(2);
            exponent(i) = fg(i).aperiodic_params(3);
        else
            exponent(i)=fg(i).aperiodic_params(2);
        end

        CF = [];    PH = [];    BW = [];
        if ~isempty(fg(i).peak_params)
        CF{i}=fg(i).peak_params(:,1)';
        PH{i}=fg(i).peak_params(:,2)';
        BW{i}=fg(i).peak_params(:,3)';
        
        end
        err(i)=fg(i).error;
        r_sq(i)=fg(i).r_squared;
    end
    
end