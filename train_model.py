from numpy import loadtxt
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from keras import layers

def train_model(training_llr_filename,training_hata_filename,model_filename,epochstimes):
# load the dataset
	InputLlr = loadtxt(training_llr_filename)
	EncodedBits = loadtxt(training_hata_filename)

	#InputLlr = loadtxt('/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/llr_K_8_N_32_L_8_blnum_8000_5_0_0')
	#EncodedBits = loadtxt('/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/hata_K_8_N_32_L_8_blnum_8000_5_0_0')
	# define the keras model
	model = Sequential()
	model.add(Dense(256, input_shape=(32,), activation='relu'))
	model.add(Dense(128, activation='relu'))
	model.add(Dense(64, activation='relu'))
	model.add(Dense(8,activation='sigmoid'))

	# compile the keras model
	model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['binary_accuracy'])

	# fit the keras model on the dataset
	model.fit(InputLlr, EncodedBits, epochs=epochstimes)

	# save the keras model
	model.save(model_filename)
	del model


#train_model('/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_llr_K_8_N_32_L_8_blnum_8000_5_0_0','/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_hata_K_8_N_32_L_8_blnum_8000_5_0_0','/Users/eoahy/pythonfile/PolarTest/modeltest.keras',2**10)




