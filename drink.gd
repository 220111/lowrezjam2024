class_name Drink
extends RigidBody2D

enum DrinkType {COFFEE, TEA, COOKIE}

@export var type: DrinkType;
var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_constant_central_force(Vector2(0, -speed))

func get_type_int() -> int:
	match type:
		DrinkType.COFFEE:
			return 0
		DrinkType.TEA:
			return 1
		DrinkType.COOKIE:
			return 2
		_:
			return 0
