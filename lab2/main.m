objective = @noisyQuartic; % Minimization
dimension = 30;
lower_bound = -1.28 * ones(1,dimension);
upper_bound = 1.28 * ones(1,dimension);
T = 500000;
nbGen = 0; % generation counter 迭代次数
nbEval = 0; % evaluation counter 评估次数
bestSoFarFit = inf; % best-so-far fitness value     目前为止最适应
bestSoFarSolution = NaN; % best-so-far solution     最适应的解
fitness_gen=[]; % record the best fitness so far    每一代最适应值
fitness_pop=[];% record the best fitness in current population  每一代最适应的解
%% Below starting your code

% Initialise a population
%% TODO
populationSize = 30;
recombination_weight = 0.4;
population = rand(populationSize, dimension).*(upper_bound-lower_bound) + lower_bound;
fitness = nan(populationSize, 1);
% Evaluate the initial population
%% TODO

for i = 1:populationSize
    fitness(i) = objective(population(i,:));
    if fitness(i) < bestSoFarFit
        bestSoFarFit = fitness(i);
        bestSoFarSolution = population(i,:);
    end
end
nbEval = nbEval + populationSize;
fitness_gen = [fitness_gen, bestSoFarFit];
fitness_pop = [fitness_pop, bestSoFarFit];
% Start the loop
while (nbEval<T) % [QUESTION] this stopping condition is not perfect, why?
% Reproduction (selection, crossver)
%% TODO
crossoverProb = fitness./sum(fitness); % roulette-wheel selection
offspring = zeros(populationSize, dimension);
offspring_fitness = nan(populationSize, 1);
for i = 1:populationSize/2
    parentIndexes = [];
    for j = 1:2
        r = rand();
        for index = 1:populationSize
            if r>sum(crossoverProb(1:index-1)) && r<=sum(crossoverProb(1:index))
                break;
            end
        end
        parentIndexes = [parentIndexes, index];
    end
    % recombination method
    [offspring(2*i-1,:), offspring(2*i,:)] = Single_Arithmetic(population(parentIndexes(1),:), population(parentIndexes(2),:), rand(1));
    %[offspring(2*i-1,:), offspring(2*i,:)] = Simple_Arithmetic(population(parentIndexes(1),:), population(parentIndexes(2),:), recombination_weight);
    
end
% Mutation
%% TODO
mutation_rate = 1/dimension;
step_size = 0.001;
for i = 1:populationSize
    % mutation method
    %offspring(i,:) = Uniform_Mutation(offspring(i,:),mutation_rate, lower_bound, upper_bound);
    offspring(i,:) = Cauchy_Mutation(offspring(i,:), lower_bound, upper_bound,step_size);
    %offspring(i,:) = Guassian_Mutation(offspring(i,:), lower_bound, upper_bound,step_size);
    

    offspring_fitness(i) = objective(offspring(i,:));
end

for i = 1:populationSize
    if offspring_fitness(i) < bestSoFarFit
        bestSoFarFit = offspring_fitness(i);
        bestSoFarSolution = offspring(i,:);
    end
end
nbEval = nbEval + populationSize;
nbGen = nbGen + 1;
%% Replacement
population = offspring;
fitness = offspring_fitness;
fitness_gen = [fitness_gen, bestSoFarFit];
fitness_pop = [fitness_pop, min(fitness)];
end
bestSoFarFit
bestSoFarSolution

figure,plot(fitness_gen,'b') 
title('Fitness\_Gen')

figure,plot(fitness_pop,'b') 
title('Fitness\_Pop')
