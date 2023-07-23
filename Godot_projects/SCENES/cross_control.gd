extends Control

@onready var cross_control = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cross_control.set_modulate(GlobalVariables.cross_color) 

