function [a] = mutation(a)
pos = randi([1,5],1)
a(pos)=num2str(abs(str2num(a(pos))-1))
end