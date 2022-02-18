function [result]=selection(solution_gen)%使用轮盘赌在一个数组种选择一个元素
temp_gen=solution_gen
sum_gen = sum(solution_gen)
for i=2:length(solution_gen)
    temp_gen(i)=temp_gen(i-1)+temp_gen(i)
end 
temp_gen = temp_gen/sum_gen
r = rand()
for i = 1:length(temp_gen)
    if r < temp_gen(i)
        result = solution_gen(i)
        break
    end
end
end

