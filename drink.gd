class_name Drink
extends RigidBody2D

enum drinkType {TEA, COFFEE}

@export var type: drinkType;
var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_constant_central_force(Vector2(0, -speed))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
