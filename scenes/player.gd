class_name Player
extends CharacterBody2D

const COFFEE_INDEX : int = 0;
const TEA_INDEX : int = 1;
const COOKIE_INDEX : int = 2;

signal action_pressed
signal items_updated

@export var speed = 35
const TEA = preload("res://scenes/tea.tscn")
const COFFEE = preload("res://scenes/coffee.tscn")
const COOKIE = preload("res://scenes/cookie.tscn")

@onready var items: Array[int] = [0,0,0];

var action_mode := false

@onready var parent = self.get_parent()

func _ready() -> void:
	items_updated.emit(items)

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("action")):
		action_pressed.emit()
	elif (action_mode == false):
		if(Input.is_action_just_pressed("fireCoffee") and items[COFFEE_INDEX] > 0):
			items[COFFEE_INDEX] -= 1
			var coffee = COFFEE.instantiate()
			coffee.global_position = global_position
			coffee.global_position.y -= 5
			parent.add_child(coffee)
			items_updated.emit(items)
		elif(Input.is_action_just_pressed("fireTea") and items[TEA_INDEX] > 0):
			items[TEA_INDEX] -= 1
			var tea = TEA.instantiate()
			tea.global_position = global_position
			tea.global_position.y -= 5
			parent.add_child(tea)
			items_updated.emit(items)
		elif(Input.is_action_just_pressed("fireCookie") and items[COOKIE_INDEX] > 0):
			items[COOKIE_INDEX] -= 1
			var cookie = COOKIE.instantiate()
			cookie.global_position = global_position
			cookie.global_position.y -= 5
			parent.add_child(cookie)
			items_updated.emit(items)
	

func get_input():
	var input_direction = Input.get_axis("left", "right")
	velocity.x = input_direction * speed
	if(action_mode):
		velocity.x = 0;

func _physics_process(delta):
	get_input()
	move_and_slide()

func start_action_mode():
	action_mode = true

func end_action_mode():
	action_mode = false

func add_coffee():
	items[COFFEE_INDEX] += 1;
	items_updated.emit(items)

func add_tea():
	items[TEA_INDEX] += 1;
	items_updated.emit(items)

func add_cookie():
	items[COOKIE_INDEX] += 1;
	items_updated.emit(items)

func is_in_action_mode() -> bool:
	return action_mode
