% set python environment
pyenv(Version="/Users/eoahy/anaconda3/bin/python3")
addpath(genpath('../'))
%check necessary environment fot deep learning
%pyrunfile("/Users/eoahy/pythonfile/versions.py")
%pyrunfile("/Users/eoahy/pythonfile/deep_versions.py")

%pyrunfile("/Users/eoahy/pythonfile/PolarTest/train_test.py")
%pyrunfile("/Users/eoahy/pythonfile/PolarTest/evaluate_test.py")

%pyrunfile("/Users/eoahy/pythonfile/PolarTest/evaluate_model.py '/Users/eoahy/pythonfile/PolarTest/modeltest.keras' '/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_llr8_32_0_1' '/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_a8_32_0_1' '/Users/eoahy/pythonfile/PolarTest/4.txt'");
%/Users/eoahy/pythonfile/PolarTest
%pyrunfile("/Users/eoahy/pythonfile/PolarTest/evaluate_model.py") 
py.sys.path().append('/Users/eoahy/pythonfile/PolarTest')


py_train = py.importlib.import_module('train_model');
EsN0=1;
K = 8;
N = 32;
E = 32;
L = 8;
block_number = 8000;
Kfactor = 0;
seed = 0;
training_llr_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_llr_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)];
training_hata_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_hata_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)];
model_filename = ['/Users/eoahy/pythonfile/PolarTest/awgn_model_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)','.keras'];
py_train.train_model(training_llr_filename,training_hata_filename,model_filename,int64(32));
%py_mod = py.importlib.import_module('evaluate_model');
%res = py_mod.evaluate_model('/Users/eoahy/pythonfile/PolarTest/modeltest.keras','/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_llr8_32_0_1','/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_a8_32_0_1','/Users/eoahy/pythonfile/PolarTest/4.txt');
%res=cell(res);
%loss = cell2mat(res(1));
%binary_accuracy = cell2mat(res(2));
