extends Control



func _ready():
	pass 

func _on_start_pressed():
	get_tree().change_scene_to_file("res://SCENES/environment.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://SCENES/Settings_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()





