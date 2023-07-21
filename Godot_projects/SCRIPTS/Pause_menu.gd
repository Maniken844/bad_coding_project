extends Control

@onready var pause_menu = $PauseMenu
@onready var color_rect = $ColorRect
@onready var pause_menus = $"."

func _ready():
	pause_menus.visible = false
	pause_menu.visible = false


func pause():
	get_tree().paused = true
	pause_menus.visible = true
	pause_menu.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://SCENES/environment.tscn")
	get_tree().paused = false

func _on_resume_button_pressed():
	get_tree().paused = false
	pause_menu.visible = false
	pause_menus.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_settings_button_pressed():
	#get_tree().paused = false
	pause_menu.visible = false
	#get_tree().change_scene_to_file("res://SCENES/Pause_Settings.tscn")
	color_rect.visible = true
	print("OK")

func _on_exit_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://SCENES/Main_menu.tscn")
	get_tree().paused = false




	



