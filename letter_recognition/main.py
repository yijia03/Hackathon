import csv
import numpy as np

# key for labels to digits & letters
key = np.array(['0','1','2','3','4','5','6','7','8','9',
       'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
       'a','b','d','e','f','g','h','n','q','r','t'])

class LetterReader:

    # read weights from csv files, transpose them
    def __init__(self):
        self.theta1_T = []; self.theta2_T = []; self.theta3_T = []

        with open('AI_Training/Output/Theta1.csv', 'r') as f:
            reader = csv.reader(f, quoting = csv.QUOTE_NONNUMERIC)
            for line in reader:
                self.theta1_T.append(line[:])
        
        self.theta1_T = np.array(self.theta1_T).T

        with open('AI_Training/Output/Theta2.csv', 'r') as f:
            reader = csv.reader(f, quoting = csv.QUOTE_NONNUMERIC)
            for line in reader:
                self.theta2_T.append(line[:])
        
        self.theta2_T = np.array(self.theta2_T).T

        with open('AI_Training/Output/Theta3.csv', 'r') as f:
            reader = csv.reader(f, quoting = csv.QUOTE_NONNUMERIC)
            for line in reader:
                self.theta3_T.append(line[:])
        
        self.theta3_T = np.array(self.theta3_T).T

    # takes in 28x28 greyscale picture as a 784 element list (domain of 0-1), outputs a 47 element list of confidence in each possible label 
    def recog(self, arr=[]):
        arr = np.array(arr).flatten()
        arr = np.append(arr, [1])     # add bias node

        output = np.matmul(arr, self.theta1_T)
        output = np.append(output, [1])
        output = self.sigmoid(output)
        
        output = np.matmul(output, self.theta2_T)
        output = np.append(output, [1])
        output = self.sigmoid(output)

        output = np.matmul(output, self.theta3_T)
        output = self.sigmoid(output)

        return output

    # takes an array and does a sigmoid function on all elements
    def sigmoid(self, arr):
        output = []
        for element in arr:
            output.append(1 / (1 + np.exp(-element)))

        output = np.array(output)
        return output

letterReader = LetterReader()

input = []
with open('AI_Training/Output/testInput.csv', 'r') as f:
    reader = csv.reader(f, quoting = csv.QUOTE_NONNUMERIC)
    for line in reader:
        input.append(line[:])
input = np.true_divide(input, 255)

output = letterReader.recog(input)

# gets thhe indicies of the top 3 most likely characters 
outindex = np.argpartition(output, -3)[-3:]
outindex = outindex[np.argsort(output[outindex])]

print(key[output])