function matrix = string2Matrix(inputStr)
    inputStr = strtrim(inputStr); % 去除首尾空格
    rows = strsplit(inputStr, '\n'); % 按行分割字符串
    numRows = numel(rows); % 获取矩阵行数

   

    %按照第一行确定列数
    rowcount = strsplit(rows{1}, ' ');
    numcols = numel(rowcount) ;
    
     % 初始化矩阵
    matrix = zeros(numRows, numcols);
    
    % 遍历每一行
    for i = 1:numRows
        row = strsplit(rows{i}, ' '); % 按空格分割字符串
        
     
        numnow = str2double(row); % 转换为数字
        matrix(i, :) = numnow; % 将数字添加到矩阵中的当前行
    end
end
