extends CanvasLayer

@onready var pause_menu = $Pause_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_menu.visible = true
		get_tree().paused = true




func _on_resume_button_pressed():
		pause_menu.visible = false
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_exit_to_menu_button_pressed():
	get_tree().quit()
