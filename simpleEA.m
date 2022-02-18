function [bestSoFarFit ,bestSoFarSolution ...
    ]=simpleEA( ...  % name of your simple EA function
    fitFunc, ... % name of objective/fitness function
    T, ... % total number of evaluations
    input) % replace it by your input arguments

% Check the inputs
if isempty(fitFunc)
  warning(['Objective function not specified, ''' objFunc ''' used']);
  fitFunc = 'objFunc';
end
if ~ischar(fitFunc)
  error('Argument FITFUNC must be a string');
end
if isempty(T)
  warning(['Budget not specified. 1000000 used']);
  T = '1000000';
end
eval(sprintf('objective=@%s;',fitFunc));
% Initialise variables
nbGen = 0; % generation counter
nbEval = 0; % evaluation counter
bestSoFarFit = 0; % best-so-far fitness value
bestSoFarSolution = NaN; % best-so-far solution
%recorders
fitness_gen=[]; % record the best fitness so far
solution_gen=[];% record the best phenotype of each generation
fitness_pop=[];% record the best fitness in current population 
%% Below starting your code

% Initialise a population
%% TODO
parent_gen = randi([0,31],1,4);
[fitness_gen(1),index] = max(objFunc(parent_gen));
solution_gen = [solution_gen,parent_gen(index)];
fitness_pop(1) = fitness_gen(1);
%initial_gen = dec2bin(initial_gen); %转为二进制


% Evaluate the initial population
%% TODO

bestSoFarFit = fitness_gen;
bestSoFarSolution = solution_gen;
nbEval = nbEval+4
nbGen = nbGen+1
% Start the loop
while (nbEval<T) 
% Reproduction (selection, crossver)
%% TODO
    offerspring=[]      %定义子代数组
    for i=1:2
        offspring1 = dec2bin(selection(parent_gen),5)    %从父代中根据轮盘赌选一个进行交叉变异
        offspring2 = dec2bin(selection(parent_gen),5)
        [offspring1,offspring2] = crossover(offspring1,offspring2)
        offspring1 = mutation(offspring1)
        offspring2 = mutation(offspring2)
        offerspring = [offerspring;offspring1]
        offerspring = [offerspring;offspring2]
    end

    [fitness_pop(end+1),index] = max(objFunc(bin2dec(offerspring)));
    if fitness_pop(end) > fitness_gen
        fitness_gen(end+1)=fitness_pop(end)
    else
        fitness_gen(end+1)=fitness_gen(end)
    end

    solution_gen(end+1) = bin2dec(offerspring(index,:))

    if objFunc(solution_gen(end))>bestSoFarSolution
        bestSoFarSolution=solution_gen(end)
    end

    nbEval = nbEval+4
    nbGen = nbGen+1
    parent_gen = bin2dec(offerspring);
end
% Mutation
%% TODO


bestSoFarFit = fitness_gen(end)

figure,plot([1:nbGen],fitness_gen,"b")
title('Fitness\_Gen')

figure,plot([1:nbGen],solution_gen,"c")
title('Solution\_Gen')

figure,plot([1:nbGen],fitness_pop,"m")
title('Fitness\_Gen')







