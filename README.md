# gl3_matlab_scan
SOSlab gl3_matlab_scan


### Recuirements
1. ROS melodic
2. [gl_ros_driver](https://github.com/soslab-project/gl_ros_driver) package
3. [rosserial](https://github.com/ros-drivers/rosserial) package
4. [ACSL interface board](https://github.com/YeongJunKim/acsl_interface_board) with rosserial_gimbal_3x project

##### excution
First, check correct usb port.
This example use:
- /dev/ttyUSB0/ as rosserial port,
- /dev/ttyUSB1/ as SOS lidar RS232 port.
###### Terminal 1
```shell
$~ roslaunch gl_ros_driver gl_ros_driver.launch
```
###### Terminal 2
```shell
$~ rosrun rosserial_python serial_node.py
```
##### check topic
###### Terminal 3
```shell
$~ rostopic echo /scan
```
##### Angle change.
###### Terminal 4
```shell
$~ rostopic pub -1 /gimbal_angles/...
```
