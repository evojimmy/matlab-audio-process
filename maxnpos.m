% ======================================================================
%> @brief find the positions of n biggest number in a list
%>
%> @param x: list of real number (dimension Length X 1)
%> @param n: (integer, smaller than Length)
%>
%> @retval pos: list of positions (dimension n X 1)
% ======================================================================
function [pos] = maxnpos(x, n)
    length = size(x, 1);
    n = min(n, length);
    max = -Inf * ones(n, 1);
    pos = zeros(n, 1);
    for i = 1:length
        flag = 0;
        for j = 1:n
            if x(i) > max(j)
                flag = 1;
                break
            end
        end
        if flag == 0
            continue
        end
        for k = (n-1):-1:j
            max(k+1) = max(k);
            pos(k+1) = pos(k);
        end
        max(j) = x(i);
        pos(j) = i;
    end
end
