import numpy as np
from PIL import Image
import numpy
import sys
import cv2 as cv
import matplotlib.pyplot as plt
import imutils as im
# Open image and put it in a numpy array
from scipy.interpolate import interp1d

srcArray = numpy.array(Image.open('macaw.bmp'), dtype=numpy.uint8)
w, h, _ = srcArray.shape

# Create target array, twice the size of the original image
resArray = numpy.zeros((2 * w, 2 * h, 3), dtype=numpy.uint8)

# Map the RGB values in the original picture according to the GRBR pattern#

# Blue
resArray[1::2, ::2, 2] = srcArray[:, :, 2]

# Green (top row of the Bayer matrix)
resArray[::2, ::2, 1] = srcArray[:, :, 1]

# Green (bottom row of the Bayer matrix)
resArray[1::2, 1::2, 1] = srcArray[:, :, 1]

# Red
resArray[::2, 1::2, 0] = srcArray[:, :, 0]

# Save the imgage
# Image.fromarray(resArray, "RGB").save("output.png")
fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(resArray[:, :, 0], cmap='Reds')
ax[2].imshow(resArray[:, :, 1], cmap='Greens')
ax[3].imshow(resArray[:, :, 2], cmap='Blues')
ax[4].imshow(resArray)
plt.show()

""" -----------------------------INTERPOLATION------------------------------- """
ways = ['zero', 'slinear', 'quadratic']

way = ways[0]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 2:
        G_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        R_idx.append([])
    else:
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        B_idx.append([])
        R_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])

print(len(resArray[0, :, 1]), len(G_idx))

xx = [i for i in range(len(resArray[:, :, 0]))]
# GREEN
new_G = []
for i in range(len(resArray[:, :, 1])):
    if i % 2:
        interp = interp1d(G_idx[i], resArray[i, 1::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))
    else:
        interp = interp1d(G_idx[i], resArray[i, ::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))

result_G = np.array(new_G)

# RED AND BLUE
new_R = []
new_B = []

for i in range(len(resArray[:, :, 0])):
    if not i % 2:
        interp = interp1d(R_idx[i], resArray[i, 1::2, 0], way, fill_value="extrapolate")
        y = interp(xx)
        new_R.append(np.array(y))
    else:
        interp = interp1d(B_idx[i], resArray[i, ::2, 2], way, fill_value="extrapolate")
        y = interp(xx)
        new_B.append(np.array(y))

new_R = np.array(new_R)
new_B = np.array(new_B)

new_R = im.rotate_bound(new_R, 90)
new_B = im.rotate_bound(new_B, 90)

result_R = []
result_B = []

idx = [k for k in range(0, len(resArray[:, :, 0]), 2)]

for i in range(len(resArray[:, :, 0])):
    # reds
    interp = interp1d(idx, new_R[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_R.append(np.array(y))
    # blues
    interp = interp1d(idx, new_B[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_B.append(np.array(y))

result_R = np.array(result_R)
result_B = np.array(result_B)

result_R = im.rotate_bound(result_R, -90)
result_B = im.rotate_bound(result_B, -90)

result = np.zeros(shape=(2 * w, 2 * h, 3), dtype=np.uint8)
result[:, :, 0] = result_R
result[:, :, 1] = result_G
result[:, :, 2] = result_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(result_R, cmap='Reds')
ax[2].imshow(result_G, cmap='Greens')
ax[3].imshow(result_B, cmap='Blues')
ax[4].imshow(result)
plt.show()

'-------------------------------------------------------------------------------------------'

way = ways[1]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 2:
        G_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        R_idx.append([])
    else:
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        B_idx.append([])
        R_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])

print(len(resArray[0, :, 1]), len(G_idx))

xx = [i for i in range(len(resArray[:, :, 0]))]
# GREEN
new_G = []
for i in range(len(resArray[:, :, 1])):
    if i % 2:
        interp = interp1d(G_idx[i], resArray[i, 1::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))
    else:
        interp = interp1d(G_idx[i], resArray[i, ::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))

result_G = np.array(new_G)

# RED AND BLUE
new_R = []
new_B = []

for i in range(len(resArray[:, :, 0])):
    if not i % 2:
        interp = interp1d(R_idx[i], resArray[i, 1::2, 0], way, fill_value="extrapolate")
        y = interp(xx)
        new_R.append(np.array(y))
    else:
        interp = interp1d(B_idx[i], resArray[i, ::2, 2], way, fill_value="extrapolate")
        y = interp(xx)
        new_B.append(np.array(y))

new_R = np.array(new_R)
new_B = np.array(new_B)

new_R = im.rotate_bound(new_R, 90)
new_B = im.rotate_bound(new_B, 90)

result_R = []
result_B = []

idx = [k for k in range(0, len(resArray[:, :, 0]), 2)]

for i in range(len(resArray[:, :, 0])):
    # reds
    interp = interp1d(idx, new_R[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_R.append(np.array(y))
    # blues
    interp = interp1d(idx, new_B[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_B.append(np.array(y))

result_R = np.array(result_R)
result_B = np.array(result_B)

result_R = im.rotate_bound(result_R, -90)
result_B = im.rotate_bound(result_B, -90)

result = np.zeros(shape=(2 * w, 2 * h, 3), dtype=np.uint8)
result[:, :, 0] = result_R
result[:, :, 1] = result_G
result[:, :, 2] = result_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(result_R, cmap='Reds')
ax[2].imshow(result_G, cmap='Greens')
ax[3].imshow(result_B, cmap='Blues')
ax[4].imshow(result)
plt.show()

'-------------------------------------------------------------------------------------------'

way = ways[2]
R_idx = []
G_idx = []
B_idx = []
for i in range(len(resArray[:, :, 0])):
    if i % 2:
        G_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])
        B_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        R_idx.append([])
    else:
        G_idx.append([k for k in range(0, len(resArray[i, :, 0]), 2)])
        B_idx.append([])
        R_idx.append([k for k in range(1, len(resArray[i, :, 0]), 2)])

print(len(resArray[0, :, 1]), len(G_idx))

xx = [i for i in range(len(resArray[:, :, 0]))]
# GREEN
new_G = []
for i in range(len(resArray[:, :, 1])):
    if i % 2:
        interp = interp1d(G_idx[i], resArray[i, 1::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))
    else:
        interp = interp1d(G_idx[i], resArray[i, ::2, 1], way, fill_value="extrapolate")
        y = interp(xx)
        new_G.append(np.array(y))

result_G = np.array(new_G)

# RED AND BLUE
new_R = []
new_B = []

for i in range(len(resArray[:, :, 0])):
    if not i % 2:
        interp = interp1d(R_idx[i], resArray[i, 1::2, 0], way, fill_value="extrapolate")
        y = interp(xx)
        new_R.append(np.array(y))
    else:
        interp = interp1d(B_idx[i], resArray[i, ::2, 2], way, fill_value="extrapolate")
        y = interp(xx)
        new_B.append(np.array(y))

new_R = np.array(new_R)
new_B = np.array(new_B)

new_R = im.rotate_bound(new_R, 90)
new_B = im.rotate_bound(new_B, 90)

result_R = []
result_B = []

idx = [k for k in range(0, len(resArray[:, :, 0]), 2)]

for i in range(len(resArray[:, :, 0])):
    # reds
    interp = interp1d(idx, new_R[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_R.append(np.array(y))
    # blues
    interp = interp1d(idx, new_B[i], way, fill_value="extrapolate")
    y = interp(xx)
    result_B.append(np.array(y))

result_R = np.array(result_R)
result_B = np.array(result_B)

result_R = im.rotate_bound(result_R, -90)
result_B = im.rotate_bound(result_B, -90)

result = np.zeros(shape=(2 * w, 2 * h, 3), dtype=np.uint8)
result[:, :, 0] = result_R
result[:, :, 1] = result_G
result[:, :, 2] = result_B

fig, ax = plt.subplots(1, 5)
ax[0].imshow(srcArray)
ax[1].imshow(result_R, cmap='Reds')
ax[2].imshow(result_G, cmap='Greens')
ax[3].imshow(result_B, cmap='Blues')
ax[4].imshow(result)
plt.show()
