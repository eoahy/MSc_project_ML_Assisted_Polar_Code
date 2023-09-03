from numpy import loadtxt
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from keras import layers
import keras

def evaluate_model(model_filename,evalute_llr_filename,evaluate_bits_filename,results_filename):
	model = keras.models.load_model(model_filename)
	#InputLlr = loadtxt('/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/llr8_32_0_1')
	#EncodedBits = loadtxt('/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/a8_32_0_1')

	InputLlr = loadtxt(evalute_llr_filename)
	EncodedBits = loadtxt(evaluate_bits_filename)
	results = model.predict(InputLlr)

	filename = results_filename
	with open(filename,'w') as file_object:
		for row in results:
			row = row.tolist()
			file_object.write(str(row)[1:-1]+'\n')

	loss,binary_accuracy = model.evaluate(InputLlr,EncodedBits)
	return loss,binary_accuracy
	


#rr=evaluate_model('modeltest.keras','/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_llr8_32_0_1','/Users/eoahy/Matlabfile/polar_codes_matlab_fading/PredictingData/fixawgn_a8_32_0_1','/Users/eoahy/pythonfile/PolarTest/2.txt')
