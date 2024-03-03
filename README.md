<p align="center">
  <h2 align="center">Cubes Color Filtering using MATLAB</h2>


  <p align="justify">
    
## Overview
  
This project consists of a color sorting system that uses the UR5 model robot from Universal Robots and MATLAB image processing software in order to achieve its goal. The system was able to detect the location and color of cubes on a workbench from a picture, allowing the robot to sort the objects into bins based on their color. Also, some filters that introduced noise were added to make the program more powerful and robust.
	  
  <br>Universidad de las Américas Puebla - The project was supervised by Professor José Luis Vázquez González (PhD in Electronics) "https://scholar.google.com/citations?user=Y3FiPaQAAAAJ&hl=es" 
  </p>
</p>
<be>

## Table of contents
- [Key Components](#Key_Components)
- [Installation and Setup](#Installation_and_Setup)
- [Usage](#IUsage)
- [Contributors](#Contributors)
- [Results](#Results)

<div align= "justify">

### Key Components

- UR5 Robot Arm: The UR5, a versatile industrial robot, plays a crucial role in physically handling and sorting objects. It can pick up items from a workbench and place them into designated bins

- MATLAB Image Processing: We’ve developed a robust image processing pipeline using MATLAB. It identifies the location of objects on the workbench and determines their colors. The processed data is then used to guide the robot’s actions.

### Installation and Setup

Before diving into the code, make sure you have the following prerequisites:

- UR5 robot (or a compatible robotic arm)
- MATLAB installed (version X.X or higher)
- Webcam or camera for image capture


1. Install MATLAB (R2023a or newer version). https://la.mathworks.com/help/install/install-products.html

2. Install the Image Processing Toolbox in MATLAB. https://la.mathworks.com/products/image.html

3. Clone this repository to your local machine:

```
git clone https://github.com/AldoPenaGa/UR5_CubesColorFiltering_MATLAB

```

### Usage

1. Capture the images and introduce them in the MATLAB workspace folder.
2. Run the MATLAB program (colorSorterer.m) to do the filtering and obtain the table that indicates the color of each cube in each position.
3. Program the UR5 variables and routines:
   3.1 Use the teach pendant of the UR5 to create ten variables that represent the ten cubes in the workspace. Associate the colors to a number.
   3.2 Program the routines using moveJ and moveL to set up the positions and the configurations HOME, APPROACH-PICK, PICK, APPROACH-PLACE, PLACE.

4. Update the numbers associated with each color in the variables section in order to indicate the UR5 which routine will be executing.

 Once the routines have been settled, step 3 can be skipped. 

### Results

The time elapsed for each interaction can be seen in the following figures. 

<img src="https://github.com/AldoPenaGa/UR5_ROS_Gazebo_BinPicking/blob/main/RCleanImage.png">

<img src="https://github.com/AldoPenaGa/UR5_ROS_Gazebo_BinPicking/blob/main/RNoisyImage.png">

### Contributors

| Name                          | Github                               |
|-------------------------------|--------------------------------------|
| Aldo Oziel Peña Gamboa        | https://github.com/AldoPenaGa        |
| José Miguel Zúñiga Juárez     | |
| Alessia Simonetti             | |
| Adrián Enrique Diaz Fornes    | |

