clear all;
close all;
clc;


global initial_flag;
global D; %the dimension of each studied benchmark problem.
global N; %No. of particles
global FE_max; %Max. no. of function evaluations, i.e, the maximum iteration number
global Nr; % No. of runs
global normalize; % if this value equals to 0 means no normalisation, else 1




FE_max = 10000; 
Nr = 10;
normalize = 0; 
D = 3;
N = 40;


tic
for fun=[2]  %%% choose the benchmark test funciton
    
    [LB, UB, opt_f, err] = get_fun_info(fun,D);  %%% obtain the information, such as the lower boundary, upper boundary,optimal solution and the accuracy error of each test function
    for r=1:1:Nr   
       initial_flag = 0;
       
       % Run PSO-DE
       [ new_f1_PSO_DE(r), FE1_PSO_DE(r), evolution_f_PSO_DE{r}] = PSO_DE(N,D, FE_max, fun, err, LB, UB, opt_f,normalize,r);
       
    end    
end 
toc
 
%%% calculate the suceess rate
SR_PSO_DE = Calculate_SR(err,new_f1_PSO_DE); 

%% calculate the evolution of the average fitness value
[Mean_Fe_PSO_DE, PSO_DE_Mean] = Calculate_Mean_Evolution(Nr, new_f1_PSO_DE,FE1_PSO_DE, evolution_f_PSO_DE); 

% mark the best run obtained in the experiment;
[Best_result, Best_index] = min(new_f1_PSO_DE);


% mark the best run obtained in the experiment;
[Worst_result, Worst_index] = max(new_f1_PSO_DE); 


%% output the statistical results obtained in the experiment
fprintf('Best_Result_of_PSO_DE= %e\n', min(new_f1_PSO_DE));
fprintf('Worst_Result_of_PSO_DE= %e\n', max(new_f1_PSO_DE));
fprintf('Average_Result_of_PSO_DE = %e\n', mean(new_f1_PSO_DE));
fprintf('Standard_Devidation_of_SAPSO_mSADE = %e\n\n', std(new_f1_PSO_DE));


%% output the average evaluation calls 
fprintf('NFE_of_PSO_DE = %e\n \n', mean(FE1_PSO_DE));



%% output the success rate
fprintf('The Success Rate (SR) of PSO-DE in the Test = %e\n', mean(SR_PSO_DE));
 


% visualize the fitness curves of the best,worst and average fitness values
% obtained in the experiment
figure(1)
semilogy(linspace(0,FE1_PSO_DE(Best_index),length(evolution_f_PSO_DE{Best_index})), evolution_f_PSO_DE{Best_index},'r--','linewidth',2);
hold on
semilogy(linspace(0,FE1_PSO_DE(Worst_index),length(evolution_f_PSO_DE{Worst_index})), evolution_f_PSO_DE{Worst_index},'k--','linewidth',2);
hold on
semilogy(linspace(0,Mean_Fe_PSO_DE,length(PSO_DE_Mean)), PSO_DE_Mean,'b-','linewidth',2)
ylabel('log[F(x)-F(x^*)]')
xlabel('Function Evaluation Number')
legend('The Best Result','The Worst Result','The Average Result')

%% save the simulation results obtained from the conducted experiment
save('exp_Results')
