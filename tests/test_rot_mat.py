import math

import matplotlib.pyplot as plt
import numpy as np

from test2 import StaticHandler


# Function to calculate length between two points
def calculate_length(x1, y1, x2, y2):
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


# Triangle A vertices
Ax1, Ay1, Ax2, Ay2, Ax3, Ay3 = (3.7, 1, 3.5, 1.3, 5, 1.3)
A_x_coords = [Ax1, Ax2, Ax3, Ax1]  # Adding Ax1 to close the triangle
A_y_coords = [Ay1, Ay2, Ay3, Ay1]  # Adding Ay1 to close the triangle

# Triangle B vertices
Bx1, By1, Bx2, By2, Bx3, By3 = (2, 1.5, 0.7, 2, 1.3, 3)
B_x_coords = [Bx1, Bx2, Bx3, Bx1]  # Adding Bx1 to close the triangle
B_y_coords = [By1, By2, By3, By1]  # Adding By1 to close the triangle

# Store coordinates as column vectors
A = np.array([[Ax1, Ax2, Ax3], [Ay1, Ay2, Ay3]])
B = np.array([[Bx1, Bx2, Bx3], [By1, By2, By3]])

# Find angle between the arrowed edges in A and B
vec_A = A[:, 1] - A[:, 0]
vec_B = B[:, 1] - B[:, 0]
angle_A = np.arctan2(vec_A[1], vec_A[0])
angle_B = np.arctan2(vec_B[1], vec_B[0])
angle_diff = angle_B - angle_A

# Rotation matrix
# rotation_matrix = np.array([[0.18343651, 0.98303156], [-0.98303156, 0.18343651]])
rotation_matrix = StaticHandler.cal_rot_mat(
    Ax1, Ay1, Ax2, Ay2, Ax3, Ay3,
    Bx1, By1, Bx2, By2, Bx3, By3
)

### Rotation ###

# Rotate the vertices of Triangle A
A_rotated = np.dot(rotation_matrix, np.array([A_x_coords[:-1], A_y_coords[:-1]]))

# Plotting using matplotlib
plt.figure()
plt.plot(A_x_coords, A_y_coords, 'r-', label="Original Triangle A")
plt.plot(B_x_coords, B_y_coords, 'b-', label="Triangle B")
plt.plot(np.append(A_rotated[0], A_rotated[0][0]), np.append(A_rotated[1], A_rotated[1][0]), 'y-',
         label="Rotated Triangle A")  # Closing the rotated Triangle A

# Add arrows
plt.arrow(Ax1, Ay1, Ax2 - Ax1, Ay2 - Ay1, color='r', width=0.05)
plt.arrow(Bx1, By1, Bx2 - Bx1, By2 - By1, color='b', width=0.05)
plt.arrow(A_rotated[0][0], A_rotated[1][0], A_rotated[0][1] - A_rotated[0][0], A_rotated[1][1] - A_rotated[1][0],
          color='y', width=0.05)

# Translation ###

# Find midpoint of the arrowed edge for the blue triangle
midpoint_B = np.array([(Bx1 + Bx2) / 2, (By1 + By2) / 2])

# Find midpoint of the arrowed edge for the rotated yellow triangle
midpoint_A_rotated = np.array([(A_rotated[0][0] + A_rotated[0][1]) / 2, (A_rotated[1][0] + A_rotated[1][1]) / 2])

# Compute the translation vector
translation_vector = midpoint_B - midpoint_A_rotated

# Translate the rotated yellow triangle
A_translated = A_rotated + np.reshape(translation_vector, (2, 1))

# Plotting the translated (now green) triangle
plt.plot(np.append(A_translated[0], A_translated[0][0]), np.append(A_translated[1], A_translated[1][0]), 'g-',
         label="Translated Triangle")

# Add arrow for the green triangle
plt.arrow(A_translated[0][0], A_translated[1][0], A_translated[0][1] - A_translated[0][0],
          A_translated[1][1] - A_translated[1][0], color='g', width=0.05)

### rescaling ###

# Calculate length of the arrowed edge for the blue triangle
length_B = calculate_length(Bx1, By1, Bx2, By2)

# Calculate length of the arrowed edge for the green triangle
length_A_translated = calculate_length(A_translated[0][0], A_translated[1][0], A_translated[0][1], A_translated[1][1])

# Calculate scaling factor s
s = length_B / length_A_translated

# # Scale the green triangle
A_scaled = A_translated * s

# # Recompute the midpoint for the scaled triangle's arrowed edge
midpoint_A_scaled = np.array([(A_scaled[0][0] + A_scaled[0][1]) / 2, (A_scaled[1][0] + A_scaled[1][1]) / 2])

# Compute the new translation vector
translation_vector_scaled = midpoint_B - midpoint_A_scaled

# Translate the scaled triangle
A_translated_scaled = A_scaled + np.reshape(translation_vector_scaled, (2, 1))

# Plotting the scaled (now purple) triangle
plt.plot(np.append(A_translated_scaled[0], A_translated_scaled[0][0]),
         np.append(A_translated_scaled[1], A_translated_scaled[1][0]),
         'm-', label="Scaled and Translated Triangle")

# Add arrow for the purple triangle
plt.arrow(A_translated_scaled[0][0], A_translated_scaled[1][0],
          A_translated_scaled[0][1] - A_translated_scaled[0][0],
          A_translated_scaled[1][1] - A_translated_scaled[1][0],
          color='m', width=0.05)

# Displaying the legend
plt.legend()

# Equal aspect ratio
plt.gca().set_aspect('equal', adjustable='box')

# Displaying the plot
plt.xlabel("X axis")
plt.ylabel("Y axis")
plt.show()
