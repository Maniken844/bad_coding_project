extends Control



func _process(_delta):
	$Counter.text = " FPS: " + str(Engine.get_frames_per_second()) + " "
