extends Node3D
@onready var csg_cylinder_3d = $Cylinder/CSGCylinder3D
@export var vel: float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	csg_cylinder_3d.velocity = vel
	
