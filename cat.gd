class_name Cat
extends Node2D

#enum DrinkType {COFFEE, TEA, COOKIE}

signal order_filled
signal order_incorrect
signal death_anim_done

const BUBBLE_COFFEE = preload("res://sprites/bubbles/bubble-coffee.png")
const BUBBLE_COOKIE = preload("res://sprites/bubbles/bubble-cookie.png")
const BUBBLE_TEA = preload("res://sprites/bubbles/bubble-tea.png")
const BUBBLE_MONEY = preload("res://sprites/bubbles/bubble-money.png")
const BUBBLE_UP = preload("res://sprites/bubbles/bubble-up.png")
const BUBBLE_DOWN = preload("res://sprites/bubbles/bubble-down.png")

@export var cats: Array[PackedScene]

@onready var area_2d: Area2D = $Area2D
@onready var bubble: Sprite2D = $Bubble
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var progress_bar: TextureProgressBar = $Control/TextureProgressBar
@onready var bubble_timer: Timer = $BubbleTimer

var order:int
var order_done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble.hide()
	area_2d.body_entered.connect(check_collision)
	animation_player.play("bubble")
	timer.timeout.connect(order_incorrect.emit)
	_load_cat()
	_set_flip()
	_select_order()
	_show_order()

func _process(_delta: float) -> void:
	if(order_done):
		timer.paused = true
		progress_bar.hide()
	else:
		progress_bar.value = (timer.time_left/timer.wait_time)*6

func init_timer(time: float):
	timer.start(time)

func check_collision(body: Node2D) -> void:
	if order_done:
		return
	var drink := body as Drink
	if not drink:
		return
	print("drink was " + str(drink.get_type_int()))
	print("wants " + str(order))
	if(drink.get_type_int() == order):
		order_filled.emit()
		bubble.texture = BUBBLE_MONEY
		order_done = true
	else:
		order_incorrect.emit()
	drink.queue_free()

func _load_cat():
	var cat_number = randi_range(0, cats.size()-1)
	var cat = cats[cat_number].instantiate()
	add_child(cat)

func _set_flip():
	var flip = randi() % 2 == 0
	scale.x = -1 if flip else 1 

func _select_order():
	order = randi_range(0,2)

func _show_order():
	match order:
		0:
			bubble.texture = BUBBLE_COFFEE
		1:
			bubble.texture = BUBBLE_TEA
		2:
			bubble.texture = BUBBLE_COOKIE
	bubble.show()

func free_self():
	if (order_done):
		bubble.texture = BUBBLE_UP
	else:
		bubble.texture = BUBBLE_DOWN
	bubble_timer.timeout.connect(death_anim_done.emit)
	bubble_timer.start()
