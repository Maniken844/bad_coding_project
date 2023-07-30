extends Node3D

@onready var world_environment = $WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready():
	world_environment.environment.volumetric_fog_enabled = GlobalVariables.Volum_Fog_Is_On
	world_environment.environment.sdfgi_enabled = GlobalVariables.SDFGI_is_on



