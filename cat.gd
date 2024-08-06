class_name Cat
extends Node2D

@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(check_collision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_collision(body: Node2D) -> void:
	var drink := body as Drink
	if not drink:
		return
	drink.queue_free()
	queue_free()
