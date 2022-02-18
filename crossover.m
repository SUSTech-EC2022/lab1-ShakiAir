function [a,b]=crossover(a,b)
pos = randi([1,4],1)
temp = a(1:pos)
a(1:pos) = b(1:pos)
b(1:pos) = temp
end