extends CharacterBody2D

@export var speed = 35

func get_input():
	var input_direction = Input.get_axis("left", "right")
	velocity.x = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	position.x = round(position.x)
	position.y = round(position.y)
