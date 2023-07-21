extends Control
#containers
@onready var display_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container
@onready var controls_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Controls_Container
@onready var graphics_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Graphics_Container
@onready var other_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Other_Container
@onready var audio_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio_Container
#toggles
@onready var fullscreen_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/Fullscreen_toggle
@onready var vsync_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/Vsync_toggle

@onready var display_mode = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/DisplayMode



func _ready():
	#check if fullscreen mode is on
	if DisplayServer.window_get_mode() != 0:
		display_mode.select(display_mode.get_item_index(DisplayServer.window_get_mode()))
	#check if vsync is on
	if DisplayServer.window_get_vsync_mode() == 1:
		vsync_toggle.set_pressed_no_signal(true)



func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://SCENES/Main_menu.tscn")





func _on_display_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.hide()
	display_container.show()
	audio_container.hide()

func _on_fullscreen_toggle_toggled(button_pressed):
	pass
	#if button_pressed == true:
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#else: 
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_display_mode_item_selected(index):
	DisplayServer.window_set_mode(display_mode.get_selected_id())


func _on_vsync_toggle_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else: 
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)



func _on_controls_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.show()
	display_container.hide()
	audio_container.hide()

func _on_graphics_focus_entered():
	graphics_container.show()
	other_container.hide()
	controls_container.hide()
	display_container.hide()
	audio_container.hide()

func _on_other_focus_entered():
	graphics_container.hide()
	other_container.show()
	controls_container.hide()
	display_container.hide()
	audio_container.hide()

func _on_audio_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.hide()
	display_container.hide()
	audio_container.show()






