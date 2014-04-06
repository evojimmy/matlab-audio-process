% ======================================================================
%> @brief get basename of filename
%>
%> @param filename: string, like 'aaa.bbb.wav'
%> @param base: string, like 'wav'
%>
%> @retval basen: string, like 'aaa.bbb' 
% ======================================================================
function [ basen ] = basename( filename, base )
    cell = regexpi(filename, ['^(.+)\.' base '$'], 'tokens', 'once');
    basen = cell{1};
end

