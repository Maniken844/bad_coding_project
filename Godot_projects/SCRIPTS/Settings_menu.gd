extends Control

#containers
@onready var display_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container
@onready var controls_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Controls_Container
@onready var graphics_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Graphics_Container
@onready var other_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Other_Container
@onready var audio_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio_Container
@onready var gameplay_container = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container

#display
@onready var vsync_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/Vsync_toggle
@onready var display_mode = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/DisplayMode
#gameplay
@onready var fov_static = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/FoV
@onready var dynamic_fov_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/Dynamic_FOV_toggle
@onready var crosshair_panel = $ColorRect/CenterContainer/PanelContainer/Crosshair_Panel
@onready var crosshair_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/Crosshair_toggle



func _ready():
	#check if fullscreen mode is on
	if DisplayServer.window_get_mode() != 0:
		display_mode.select(display_mode.get_item_index(DisplayServer.window_get_mode()))
	#check if vsync is on
	if DisplayServer.window_get_vsync_mode() == 1:
		vsync_toggle.set_pressed_no_signal(true)
	#check if fov is not default
	if GlobalVariables.camera_fov != 75 :
		fov_static.tooltip_text = "Field Of View (FOV): " + str(GlobalVariables.camera_fov)
		fov_static.value = GlobalVariables.camera_fov
	#check if dynamic fov is on
	if GlobalVariables.Is_Dynamic_Fov_ON == true:
		dynamic_fov_toggle.set_pressed_no_signal(true)


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
	gameplay_container.hide()


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
	gameplay_container.hide()

func _on_graphics_focus_entered():
	graphics_container.show()
	other_container.hide()
	controls_container.hide()
	display_container.hide()
	audio_container.hide()
	gameplay_container.hide()

func _on_other_focus_entered():
	graphics_container.hide()
	other_container.show()
	controls_container.hide()
	display_container.hide()
	audio_container.hide()
	gameplay_container.hide()

func _on_audio_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.hide()
	display_container.hide()
	audio_container.show()
	gameplay_container.hide()

func _on_gameplay_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.hide()
	display_container.hide()
	audio_container.hide()
	gameplay_container.show()
	
	if GlobalVariables.Crosshair_Is_On == true:
		crosshair_panel.show()
		crosshair_toggle.set_pressed_no_signal(true)

#FOV & Dynamic FOV
func _on_fo_v_value_changed(value):
	fov_static.tooltip_text = "Static Field Of View (FOV) value: " + str(fov_static.value)
func _on_fo_v_drag_ended(value_changed):
	GlobalVariables.camera_fov = fov_static.value
func _on_dynamic_fov_toggle_toggled(button_pressed):
	GlobalVariables.Is_Dynamic_Fov_ON = true






func _on_crosshair_toggle_toggled(button_pressed):
	if button_pressed:
		crosshair_panel.show()
		GlobalVariables.Crosshair_Is_On = true
	elif !button_pressed:
		crosshair_panel.hide()
		GlobalVariables.Crosshair_Is_On = false
