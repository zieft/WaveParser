import matplotlib.pyplot as plt
import numpy as np

# Triangle A vertices
Ax1, Ay1, Ax2, Ay2, Ax3, Ay3 = (3.7, 1, 4.5, 2.3, 5, 1.3)
A_x_coords = [Ax1, Ax2, Ax3, Ax1]  # Adding Ax1 to close the triangle
A_y_coords = [Ay1, Ay2, Ay3, Ay1]  # Adding Ay1 to close the triangle

# Triangle B vertices
Bx1, By1, Bx2, By2, Bx3, By3 = (2, 1.5, 0.7, 2, 1.3, 3)
B_x_coords = [Bx1, Bx2, Bx3, Bx1]  # Adding Bx1 to close the triangle
B_y_coords = [By1, By2, By3, By1]  # Adding By1 to close the triangle

# Rotation matrix
rotation_matrix = np.array([[0.18343651, 0.98303156], [-0.98303156, 0.18343651]])

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

# Displaying the legend
plt.legend()

# Equal aspect ratio
plt.gca().set_aspect('equal', adjustable='box')

# Displaying the plot
plt.xlabel("X axis")
plt.ylabel("Y axis")
plt.show()
