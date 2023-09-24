function output = energyfunc(input)
    output = zeros(size(input));  % Initialize the output array
    h=0.51;
    for i = 1:numel(input)
        if input(i) >=0  && input(i) < h
            output(i) = 1; % Assign -1 if the number is negative
        elseif input(i) >= h && input(i) < 1
            output(i) = 0.5*(1+cos(pi*(input(i)-h)/(1-h))); % Assign 0 if the number is between 0 and 10 (inclusive)
        else
            output(i) = 0;  % Assign 1 if the number is greater than 10
        end
    end
end
