function value=XMLread(filename,field)


% Read the XML file
S = readstruct(filename);


if isfield(S, field)
    value = S.(field);
else
    error(['字段 ', field, ' 不存在']);
end

if value.typeAttribute=='Eigen::MatrixXd'
    value = string2Matrix(value.value);
    return
end

if value.typeAttribute=='double' || value.typeAttribute=='int' 
    value = (value.value);
    return
end

if value.typeAttribute=='string'
    value = value.value;
    return
end


end
