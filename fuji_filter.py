import numpy as np
from PIL import Image
import numpy
import sys
import matplotlib.pyplot as plt
import cv2 as cv
from scipy.interpolate import interp1d

# Open image and put it in a numpy array
# R = cv.imread('R.png')
# G = cv.imread('G.png')
# B = cv.imread('B.png')

srcArray = numpy.array(Image.open('RGB.png'), dtype=numpy.uint8)
# srcArray = np.zeros(shape=(R.shape[0], R.shape[1], 3), dtype=numpy.uint8)
# srcArray[:, :, 0] = R[:, :, 2]
# srcArray[:, :, 1] = G[:, :, 1]
# srcArray[:, :, 2] = B[:, :, 0]

w, h, _ = srcArray.shape

# Create target array, twice the size of the original image
resArray = numpy.zeros((6 * w, 6 * h, 3), dtype=numpy.uint8)

for j in range(srcArray.shape[0]):
    for k in range(srcArray.shape[1]):
        pix = srcArray[j][k]
        R_fuji = [[0, 0, pix[0], 0, pix[0], 0],
                  [pix[0], 0, 0, 0, 0, 0],
                  [0, 0, 0, pix[0], 0, 0],
                  [0, pix[0], 0, 0, 0, pix[0]],
                  [0, 0, 0, pix[0], 0, 0],
                  [pix[0], 0, 0, 0, 0, 0]]
        G_fuji = [[pix[1], 0, 0, pix[1], 0, 0],
                  [0, pix[1], pix[1], 0, pix[1], pix[1]],
                  [0, pix[1], pix[1], 0, pix[1], pix[1]],
                  [pix[1], 0, 0, pix[1], 0, 0],
                  [0, pix[1], pix[1], 0, pix[1], pix[1]],
                  [0, pix[1], pix[1], 0, pix[1], pix[1]]]
        B_fuji = [[0, pix[2], 0, 0, 0, pix[2]],
                  [0, 0, 0, pix[2], 0, 0],
                  [pix[2], 0, 0, 0, 0, 0],
                  [0, 0, pix[2], 0, pix[2], 0],
                  [pix[2], 0, 0, 0, 0, 0],
                  [0, 0, 0, pix[2], 0, 0]]
        resArray[6 * j:6 * j + 6, 6 * k:6 * k + 6, 0] = R_fuji
        resArray[6 * j:6 * j + 6, 6 * k:6 * k + 6, 1] = G_fuji
        resArray[6 * j:6 * j + 6, 6 * k:6 * k + 6, 2] = B_fuji

# Save the imgage
# Image.fromarray(resArray, "RGB").save("output.png")
fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(resArray[:, :, 0], cmap='Reds')
ax[2].imshow(resArray[:, :, 1], cmap='Greens')
ax[3].imshow(resArray[:, :, 2], cmap='Blues')
ax[4].imshow(resArray)
plt.show()

# cv.imwrite('RGB.png', srcArray)

"""-------------------------------INTERPOLATION-----------------------------"""
ways = ['zero', 'slinear', 'quadratic']

way = ways[0]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 6 == 0:
        R_idx.append(sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
    elif i % 6 in [1, 5]:
        R_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
        G_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
    elif i % 6 in [2, 4]:
        R_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
        G_idx.append(
            sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
    elif i % 6 == 3:
        R_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(
            sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))

new_R = []
new_G = []
new_B = []
xx = [i for i in range(len(resArray[:, :, 0]))]
for i in range(len(resArray[:, :, 0])):
    # RED
    interp = interp1d(R_idx[i], [resArray[i, r, 0] for r in R_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_R.append(np.array(y))
    # GREEN
    interp = interp1d(G_idx[i], [resArray[i, g, 1] for g in G_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_G.append(np.array(y))
    # BLUE
    interp = interp1d(B_idx[i], [resArray[i, b, 2] for b in B_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_B.append(np.array(y))

result = np.zeros(shape=(6*w, 6*h, 3), dtype=np.uint8)
result[:, :, 0] = new_R
result[:, :, 1] = new_G
result[:, :, 2] = new_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(new_R, cmap='Reds')
ax[2].imshow(new_G, cmap='Greens')
ax[3].imshow(new_B, cmap='Blues')
ax[4].imshow(result)
plt.show()


'------------------------------------------------------------------------------------------'

way = ways[1]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 6 == 0:
        R_idx.append(sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
    elif i % 6 in [1, 5]:
        R_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
        G_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
    elif i % 6 in [2, 4]:
        R_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
        G_idx.append(
            sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
    elif i % 6 == 3:
        R_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(
            sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))

new_R = []
new_G = []
new_B = []
xx = [i for i in range(len(resArray[:, :, 0]))]
for i in range(len(resArray[:, :, 0])):
    # RED
    interp = interp1d(R_idx[i], [resArray[i, r, 0] for r in R_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_R.append(np.array(y))
    # GREEN
    interp = interp1d(G_idx[i], [resArray[i, g, 1] for g in G_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_G.append(np.array(y))
    # BLUE
    interp = interp1d(B_idx[i], [resArray[i, b, 2] for b in B_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_B.append(np.array(y))

result = np.zeros(shape=(6*w, 6*h, 3), dtype=np.uint8)
result[:, :, 0] = new_R
result[:, :, 1] = new_G
result[:, :, 2] = new_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(new_R, cmap='Reds')
ax[2].imshow(new_G, cmap='Greens')
ax[3].imshow(new_B, cmap='Blues')
ax[4].imshow(result)
plt.show()

'------------------------------------------------------------------------------------------'



way = ways[2]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 6 == 0:
        R_idx.append(sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
    elif i % 6 in [1, 5]:
        R_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
        G_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
    elif i % 6 in [2, 4]:
        R_idx.append([k for k in range(3, len(resArray[i, :, 0]), 6)])
        G_idx.append(
            sorted([k for k in range(1, len(resArray[i, :, 0]), 3)] + [k for k in range(2, len(resArray[i, :, 0]), 3)]))
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 6)])
    elif i % 6 == 3:
        R_idx.append(sorted([k for k in range(1, len(resArray[i, :, 0]), 6)] + [k for k in range(5, len(resArray[i, :, 0]), 6)]))
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 3)])
        B_idx.append(
            sorted([k for k in range(2, len(resArray[i, :, 0]), 6)] + [k for k in range(4, len(resArray[i, :, 0]), 6)]))

new_R = []
new_G = []
new_B = []
xx = [i for i in range(len(resArray[:, :, 0]))]
for i in range(len(resArray[:, :, 0])):
    # RED
    interp = interp1d(R_idx[i], [resArray[i, r, 0] for r in R_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_R.append(np.array(y))
    # GREEN
    interp = interp1d(G_idx[i], [resArray[i, g, 1] for g in G_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_G.append(np.array(y))
    # BLUE
    interp = interp1d(B_idx[i], [resArray[i, b, 2] for b in B_idx[i]], way, fill_value="extrapolate")
    y = interp(xx)
    new_B.append(np.array(y))

result = np.zeros(shape=(6*w, 6*h, 3), dtype=np.uint8)
result[:, :, 0] = new_R
result[:, :, 1] = new_G
result[:, :, 2] = new_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(new_R, cmap='Reds')
ax[2].imshow(new_G, cmap='Greens')
ax[3].imshow(new_B, cmap='Blues')
ax[4].imshow(result)
plt.show()
