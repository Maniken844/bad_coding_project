extends Node
#Settings Variables
var camera_fov = 75
var Max_fps = 0
var Is_Dynamic_Fov_ON = true
var Crosshair_Is_On = true
var FPS_Counter_Is_On = true
var Is_Camera_Tilt_ON = true
var Volum_Fog_Is_On = false
var SDFGI_is_on = false
#range 0.0 - 1.0 (crosshair color)
var cross_color = Color(1, 1, 1, 1)

#shadows mode value (not working)
var shadows_mode_id = 2
#shadows on/off (not working)
var Is_Shadows_On = true
#gravity
var player_gravity = 13.0

#InGame variables
var is_crouching = false
var is_on_floor = false
