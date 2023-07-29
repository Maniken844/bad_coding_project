extends Node

var camera_fov = 75
var Is_Dynamic_Fov_ON = false
var is_crouching = false
var is_on_floor = false
var Crosshair_Is_On = false
var FPS_Counter_Is_On = false
var Is_Camera_Tilt_ON = false
#range 0.0 - 1.0 (crosshair color)
var cross_color = Color(1, 1, 1, 1)

#shadows mode value
var shadows_mode_id = 2
#shadows on/off
var Is_Shadows_On = true
#gravity
var player_gravity = 13.0
