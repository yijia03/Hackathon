from uu import decode
from flask import Flask, request, jsonify, make_response
from PIL import Image, ImageOps
from io import BytesIO

app = Flask(__name__)

import csv
import numpy as np
import base64 

# key for labels to digits & letters
key = np.array(['0','1','2','3','4','5','6','7','8','9',
       'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
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

    # takes in 28x28 greyscale picture as a 784 element list (domain of 0-255), outputs a 47 element list of confidence in each possible label 
    def recog(self, arr=[]):
        arr = np.array(arr).flatten()
        arr = np.true_divide(arr, 255)

        arr = np.append([1], arr)     # add bias node
        output = np.matmul(arr, self.theta1_T)
        output = self.sigmoid(output)

        output = np.append([1], output)
        output = np.matmul(output, self.theta2_T)
        output = self.sigmoid(output)
        
        output = np.append([1], output)
        output = np.matmul(output, self.theta3_T)
        output = self.sigmoid(output)

        return output

    # takes an array and does a sigmoid function on all elements
    def sigmoid(self, arr):
        output = []
        for element in arr:
            output.append(1.0 / (1.0 + np.exp(-element)))

        output = np.array(output)
        return output

reader = LetterReader()

class IdentifiedCharacter:
    
    def __init__(self, pixelsX=[], pixelsY=[]):
        return

def floodFill(matrix=[], x=0, y=0, backPos=(0,0)):
    nextResults = []
    val = matrix[y][x]
    matrix[y][x] = 0 
    if val > 50:  
        nextResults += [(x, y, val)]
        #recursively invoke flood fill on all surrounding cells:
        if x > 0:
            nextResults += floodFill(matrix,x-1,y)
        if x < len(matrix[0]) - 1:
            nextResults += floodFill(matrix,x+1,y)
        if y > 0:
            nextResults += floodFill(matrix,x,y-1)
        if y < len(matrix) - 1:
            nextResults += floodFill(matrix,x,y+1)
    return nextResults

# takes a b64 encoded image and processes all letters within it, returns each letter it guessed in order
def doImage(encoded='', size=[]):
    decodedImage = base64.b64decode(encoded) 
    decodedImage = Image.open(BytesIO(decodedImage))

    # to black and white
    bkgd = Image.new("RGBA", decodedImage.size, "WHITE") # Create a white rgba background
    bkgd.paste(decodedImage, (0, 0), decodedImage)
    image = ImageOps.invert(bkgd.convert('L'))
    
    # resize to lower complexity and to np array 
    image = image.resize((round(size[0] / 4), round(size[1] / 4)))
    imgarr = np.array(image)

    # transform for neural net (imgarr[0][0] is the top left corner of the image transformed for the neutral net)
    imgarr = np.fliplr(imgarr)
    imgarr = np.rot90(imgarr)
    imgarr = imgarr.tolist()

    # flood fill to identify each character from top to bottom (right to left in original picture, reverse the order later)
    characters = []
    for y in range(len(imgarr)):
        for x in range(len(imgarr[0])):
            if(imgarr[y][x] != 0):
                characters.append(floodFill(imgarr, x, y))

    filtered_characters = [ele for ele in characters if (ele != [] and len(ele) > 15)]

    # find offsets of each character, reconstruct it with 2 black columns on each side, make it a square as needed, rescale to 28x28, send to neutral net
    estimate = []
    for character in filtered_characters:
        # find dimensions
        width=0; height=0; xOffset=character[0][0]; yOffset=character[0][1]
        for pixel in character:
            if (pixel[0] < xOffset):
                width += xOffset - pixel[0]
                xOffset = pixel[0]
            if (pixel[1] < yOffset):
                height += yOffset - pixel[1]
                yOffset = pixel[1]
            if (pixel[0] - xOffset > width):
                width = pixel[0] - xOffset
            if (pixel[1] - yOffset > height):
                height = pixel[1] - yOffset
        
        # create new array of just character pixels
        charArr = np.zeros((height + 1, width + 1))
        for pixel in character:
            charArr[pixel[1] - yOffset][pixel[0] - xOffset] = pixel[2]

        # make it a 22x22 square
        while width < height:
            charArr = np.append(np.zeros((height + 1, 1)), charArr, axis = 1)
            charArr = np.append(charArr, np.zeros((height + 1, 1)), axis = 1)
            width += 2
        while height < width:
            charArr = np.append(np.zeros((1, width + 1)), charArr, axis = 0)
            charArr = np.append(charArr, np.zeros((1, width + 1)), axis = 0)
            height += 2
        charImg = Image.fromarray(charArr)
        charImg = charImg.resize((22,22))

        charArr = np.array(charImg)        
        charArr = np.append(np.zeros((22, 3)), charArr, axis = 1)
        charArr = np.append(charArr, np.zeros((22, 3)), axis = 1)
        charArr = np.append(np.zeros((3, 28)), charArr, axis = 0)
        charArr = np.append(charArr, np.zeros((3, 28)), axis = 0)

        #Send to neural net
        estimate += [reader.recog(charArr)]
    
    return estimate

# compares result of estimates and actual answer, returns 1 if they are deemed similar enough, otherwise 0
def compAnswers(estimate=[], answer=''):

    estimatedString = ""
    correct = 1

    for x in range(len(answer)):
        # get top 3 most confident answers
        output = estimate[x]
        outindex = np.argpartition(output, -5)[-5:]
        outindex = outindex[np.argsort(output[outindex])]
        possibleCharacters = [char.lower() for char in key[outindex]]

        estimatedString += key[outindex][4].lower()

        # get confidence of actual answer
        matchingAns = answer[x]
        if matchingAns in ['c', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 's', 'u', 'v', 'w', 'x', 'y', 'z']:
            matchingAns = matchingAns.upper()
        confidence = output[key.tolist().index(matchingAns)]

        # conditions for giving the user the point for the character
        if answer[x].lower in possibleCharacters or confidence > 0.01:
            correct = 1
        else:
            correct = 0
    
    if correct == 1:
        return [1, answer]
    return [0, estimatedString]

@app.route('/read', methods=['GET', 'POST'])
def readLetters():
    # get data from app
    content_type = request.headers.get('Content-Type')
    json = request.json

    answer = json.answer
    written = json.data
    size = [json.width, json.height]

    # process image
    userEstimate = doImage(written, size)

    # answers
    output = compAnswers(userEstimate, answer)

    response = make_response(jsonify({"output": output[0], "user_estimated_answer": output[1]}), 401)
    response.headers["Content-Type"] = "application/json"
    return response

@app.route('/test')
def test():
    print("app_is_running")
    return "hello world"

if __name__ == "__main__":
    app.run()     #UNCOMMENT THIS!

## TESTING PURPOSES ##
# letterReader = LetterReader()

# input = []
# with open('AI_Training/Output/testInput.csv', 'r') as f:
#     csvreader = csv.reader(f, quoting = csv.QUOTE_NONNUMERIC)
#     for line in csvreader:
#         input.append(line[:])

# output = letterReader.recog(input)

# # gets thhe indicies of the top 3 most likely characters, the last element is the most likely
# outindex = np.argpartition(output, -3)[-3:]
# outindex = outindex[np.argsort(output[outindex])]
# print(key[46])
# print(outindex)
# # print(key[outindex])

# f = open('Test/lmaoiT.txt')
# estimate = doImage(f.read(), [393, 200])
# output = compAnswers(estimate, 'lmaoit')
# print(output)