extends Camera3D

@onready var player = $"../.."
@onready var head = $"../"
var max_crouch_fov = GlobalVariables.camera_fov -15.0
var based_fov = GlobalVariables.camera_fov
var max_walk_fov = GlobalVariables.camera_fov + 20.0
var max_sprint_fov = GlobalVariables.camera_fov + 40.0

var curRotation = 0
var maxTilt = 5

func _ready():
	curRotation = rotation.y
	if GlobalVariables.Is_Dynamic_Fov_ON == false:
		fov = GlobalVariables.camera_fov



func _process(delta):
	#Dynamic FOV
	if GlobalVariables.Is_Dynamic_Fov_ON == true:
		if Input.is_action_pressed("Up"):
			if Input.is_action_pressed("Sprint"):
				fov = lerpf(fov, max_sprint_fov, 5 * delta)
			elif Input.is_action_pressed("Crouch"):
				fov = lerpf(fov, max_crouch_fov, 5 * delta)
			else:
				if GlobalVariables.is_crouching == true:
					fov = lerpf(fov, max_crouch_fov, 5 * delta)
				else:
					fov = lerpf(fov, max_walk_fov, 5 * delta)
		elif Input.is_action_pressed("Crouch") and !Input.is_action_pressed("Sprint"):
			fov = lerpf(fov, max_crouch_fov, 5 * delta)
		else:
			if GlobalVariables.is_crouching == true:
				fov = lerpf(fov, max_crouch_fov, 5 * delta)
			else:
				fov = lerpf(fov, based_fov, 5 * delta)
	#Camera Tilting
	if GlobalVariables.Is_Camera_Tilt_ON == true:
		if curRotation > head.rotation.y:
			rotation.z = lerpf(rotation.z, deg_to_rad(-maxTilt), 5 * delta)
			curRotation = head.rotation.y
		elif curRotation < head.rotation.y:
			rotation.z = lerpf(rotation.z, deg_to_rad(maxTilt), 5 * delta)
			curRotation = head.rotation.y
		else:
			rotation.z =  lerpf(rotation.z, 0, 10 * delta)
