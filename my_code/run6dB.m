pyenv(Version="/Users/eoahy/anaconda3/bin/python3")
addpath(genpath('../'))
%check necessary environment fot deep learning
%pyrunfile("/Users/eoahy/pythonfile/versions.py")
%pyrunfile("/Users/eoahy/pythonfile/deep_versions.py")

%import my function to python path
py.sys.path().append('/Users/eoahy/pythonfile/PolarTest')

K = 8;
N = 32;
E = 32;
L = 8;
block_number = 80000;
Kfactor = 0;
training_seed = 0;
evaluate_seed = 1;
epochstime = 1024;
%import module
py_train = py.importlib.import_module('train_model');
py_evaluate = py.importlib.import_module('evaluate_model');
EsN0_range = 0:0.5:10;
loss = zeros(1,length(EsN0_range));
binary_accuracy = zeros(1,length(EsN0_range));
EsN0 = 6;
training_llr_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_llr_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
training_a_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_a_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
model_filename = ['/Users/eoahy/pythonfile/PolarTest/6dBawgn_model_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)','.keras'];
py_train.train_model(training_llr_filename,training_a_filename,model_filename,int64(epochstime));
for EsN0 = EsN0_range
    %training_llr_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_llr_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    %training_a_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_a_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    %model_filename = ['/Users/eoahy/pythonfile/PolarTest/fixawgn_model_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)','.keras'];
    %py_train.train_model(training_llr_filename,training_a_filename,model_filename,int64(epochstime));
    evalute_llr_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_llr',num2str(K),'_',num2str(N),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(evaluate_seed)];
    evaluate_bits_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_a',num2str(K),'_',num2str(N),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(evaluate_seed)];
    results_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/results/6dBawgnK_',num2str(K),'_',num2str(N),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(evaluate_seed)];
    res = py_evaluate.evaluate_model(model_filename,evalute_llr_filename,evaluate_bits_filename,results_filename);
    res=cell(res);
    loss(2*EsN0+1) = cell2mat(res(1));
    binary_accuracy(2*EsN0+1) = cell2mat(res(2));
end
filename_loss = ['./results/6dBawgn_a_loss_K_',num2str(K),'_E_',num2str(E),'_epoch_',num2str(epochstime),'_blnum_',num2str(block_number)];
filename_binary_accuracy = ['./results/6dBawgn_a_accuracy_K_',num2str(K),'_E_',num2str(E),'_epoch_',num2str(epochstime),'_blnum_',num2str(block_number)];
save(filename_loss,'loss','-ascii');
save(filename_binary_accuracy,'binary_accuracy','-ascii');
