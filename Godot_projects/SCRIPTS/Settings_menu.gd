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
@onready var fps_value_label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/FPS_value_label
@onready var fps_limit = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Display_Container/FPS_Limit
#gameplay
@onready var fo_v_value_label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/FoV_value_label
@onready var fov_static = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/FoV
@onready var dynamic_fov_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/Dynamic_FOV_toggle
@onready var crosshair_panel = $ColorRect/CenterContainer/PanelContainer/Crosshair_Panel
@onready var crosshair_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/Crosshair_toggle
@onready var cross_color_picker = $ColorRect/CenterContainer/PanelContainer/Crosshair_Panel/VBoxContainer/cross_settings/cross_color_picker
@onready var camera_tilt_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Gameplay_Container/Camera_tilt_toggle
#Graphics
@onready var shadows_mode = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Graphics_Container/Shadows_mode
@onready var fog_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Graphics_Container/Fog_toggle
@onready var sdfgi_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Graphics_Container/Sdfgi_toggle

#Other
@onready var fps_counter_toggle = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Other_Container/FPS_Counter_toggle



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
	if GlobalVariables.Is_Dynamic_Fov_ON == false:
		dynamic_fov_toggle.set_pressed_no_signal(false)
	if GlobalVariables.Is_Dynamic_Fov_ON == true:
		dynamic_fov_toggle.set_pressed_no_signal(true)
	#set color for cross_color_picker from crosshair color
	cross_color_picker.color = GlobalVariables.cross_color
	if GlobalVariables.Crosshair_Is_On == true :
		crosshair_toggle.set_pressed_no_signal(true)
	if GlobalVariables.FPS_Counter_Is_On == true:
		fps_counter_toggle.set_pressed_no_signal(true)
	if GlobalVariables.Is_Camera_Tilt_ON == true:
		camera_tilt_toggle.set_pressed_no_signal(true)
	if GlobalVariables.Volum_Fog_Is_On:
		fog_toggle.set_pressed_no_signal(true)
	if !GlobalVariables.Volum_Fog_Is_On:
		fog_toggle.set_pressed_no_signal(false)
	if GlobalVariables.SDFGI_is_on:
		sdfgi_toggle.set_pressed_no_signal(true)
	if !GlobalVariables.SDFGI_is_on:
		sdfgi_toggle.set_pressed_no_signal(false)
	#Fps limiter
	fps_limit.value = GlobalVariables.Max_fps
	if fps_limit.value == 0:
		fps_value_label.text = "Max Fps: " + "Unlimited"
	elif fps_limit.value != 0:
		fps_value_label.text = "Max Fps: " + str(fps_limit.value)


		


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://SCENES/Main_menu.tscn")





func _on_display_focus_entered():
	graphics_container.hide()
	other_container.hide()
	controls_container.hide()
	display_container.show()
	audio_container.hide()
	gameplay_container.hide()


func _on_display_mode_item_selected(_index):
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

#crosshair panel	
	if GlobalVariables.Crosshair_Is_On == true:
		crosshair_panel.show()
	if GlobalVariables.Crosshair_Is_On == false:
		crosshair_panel.hide()
func _on_gameplay_container_visibility_changed():
	crosshair_panel.hide()

#FOV & Dynamic FOV
func _on_fo_v_value_changed(value):
	fo_v_value_label.text = str(fov_static.value)
func _on_fo_v_drag_ended(_value_changed):
	GlobalVariables.camera_fov = fov_static.value
func _on_dynamic_fov_toggle_toggled(button_pressed):
	if button_pressed:
		GlobalVariables.Is_Dynamic_Fov_ON = true
	elif !button_pressed:
		GlobalVariables.Is_Dynamic_Fov_ON = false
	
func _on_fps_limit_drag_ended(_value_changed):
	GlobalVariables.Max_fps = fps_limit.value
	Engine.max_fps = fps_limit.value
	
func _on_fps_limit_value_changed(value):
	if fps_limit.value == 0:
		fps_value_label.text = "Max Fps: " + "Unlimited"
	else:
		fps_value_label.text = "Max Fps: " + str(fps_limit.value)



func _on_crosshair_toggle_toggled(button_pressed):
	if button_pressed:
		crosshair_panel.show()
		GlobalVariables.Crosshair_Is_On = true
	elif !button_pressed:
		crosshair_panel.hide()
		GlobalVariables.Crosshair_Is_On = false




func _on_cross_color_picker_color_changed(color):
	GlobalVariables.cross_color = color
	cross_color_picker.color = color



func _on_shadows_mode_item_selected(index):
	if index == 0:
		pass
		#RenderingServer.viewport_set_positional_shadow_atlas_size(Viewport,0) 
		#get_tree().root.positional_shadow_atlas_size = 0
		
	else:
		pass
		#GlobalVariables.shadows_mode_id = index+1
	#print(GlobalVariables.shadows_mode_id)
	#print(GlobalVariables.Is_Shadows_On)
	#print(RenderingServer.VIEWPORT_DEBUG_DRAW_DIRECTIONAL_SHADOW_ATLAS)
	#RenderingServer.directional_soft_shadow_filter_set_quality(GlobalVariables.shadows_mode_id)
	





func _on_fps_counter_toggle_toggled(button_pressed):
	if button_pressed:
		GlobalVariables.FPS_Counter_Is_On = true
	else:
		GlobalVariables.FPS_Counter_Is_On = false


func _on_camera_tilt_toggle_toggled(button_pressed):
	if button_pressed:
		GlobalVariables.Is_Camera_Tilt_ON = true
	else:
		GlobalVariables.Is_Camera_Tilt_ON = false


func _on_fog_toggle_toggled(button_pressed):
	if button_pressed:
		GlobalVariables.Volum_Fog_Is_On = true
	else:
		GlobalVariables.Volum_Fog_Is_On = false
















func _on_sdfgi_toggle_toggled(button_pressed):
	if button_pressed:
		GlobalVariables.SDFGI_is_on = true
	else:
		GlobalVariables.SDFGI_is_on = false
