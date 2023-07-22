extends Camera3D

@onready var player = $"../.."
var max_crouch_fov = GlobalVariables.camera_fov -15.0
var based_fov = GlobalVariables.camera_fov
var max_walk_fov = GlobalVariables.camera_fov + 20.0
var max_sprint_fov = GlobalVariables.camera_fov + 40.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.Is_Dynamic_Fov_ON == false:
		fov = GlobalVariables.camera_fov


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		elif Input.is_action_pressed("Crouch"):
			fov = lerpf(fov, max_crouch_fov, 5 * delta)
		else:
			if GlobalVariables.is_crouching == true:
				fov = lerpf(fov, max_crouch_fov, 5 * delta)
			else:
				fov = lerpf(fov, based_fov, 5 * delta)
	#print(fov)
