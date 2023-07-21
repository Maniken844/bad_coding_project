extends CharacterBody3D

var speed 
const WALK_SPEED = 5.5
const SPRINT_SPEED = 10.0
const CROUCH_SPEED = 3.5
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 1.0

#How fast Character changes from standing to crouching
var crouch_transition_speed = 10.0

#Height of the Character
var default_height = 1.5
var crouch_height = 0.75

#Shaking the camera
const SHAKE_FREQ = 2.4
const SHAKE_AMP = 0.06
var t_bob = 0.0
#checks
var is_crouching = false
var can_sprint = true
#Gravity
var gravity = 9.8

#for later sensitivity setting in settings menu
var Sens_multiplier = 100.0

@onready var Head = $Head
@onready var Camera = $Head/Camera3D
@onready var Player_Collider = $CollisionShape3D
@onready var head_bonker = $HeadBonker


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _unhandled_input(event):
	if event is InputEventMouseMotion:
		Head.rotate_y(-event.relative.x * SENSITIVITY/Sens_multiplier)
		Camera.rotate_x(-event.relative.y * SENSITIVITY/Sens_multiplier)
		Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-80), deg_to_rad(60))
	if event.is_action_pressed("Escape"):
		$PauseMenu.pause()
func _physics_process(delta):
	
	#no obstacles above head check
	var head_bonked = false
	if head_bonker.is_colliding():
		head_bonked = true
	
	#Adding the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	#Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Check player is crouching or not
	if is_crouching == true:
		can_sprint = false
	elif is_crouching == false:
		can_sprint = true

	#Sprint	
	if Input.is_action_pressed("Sprint"):
		if can_sprint == true:
			speed = SPRINT_SPEED
	elif Input.is_action_pressed("Crouch"):
		is_crouching = true
		#Crouch
		Player_Collider.shape.height -= crouch_transition_speed * delta
		speed = CROUCH_SPEED
	else: 
		if head_bonked == false:
			Player_Collider.shape.height += crouch_transition_speed * delta
			speed = WALK_SPEED
			is_crouching = false
	Player_Collider.shape.height = clamp(Player_Collider.shape.height, crouch_height, default_height)
	#restart and exit the game (DELETE AFTER FINISHING)
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
		
	#Player Camera Shaking:
	t_bob += delta * velocity.length() * float(is_on_floor())
	Camera.transform.origin = _headShake(t_bob)

	if Input.is_action_pressed("Crouch"):
		pass #crouching here
	
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0
			velocity.z = 0
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 6.5)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 6.5)
	
	move_and_slide()
	
	
func _headShake(time):
	var pos = Vector3.ZERO
	pos.y = sin(time*SHAKE_FREQ) * SHAKE_AMP
	pos.x = cos(time*SHAKE_FREQ/2) * SHAKE_AMP
	return pos

		

