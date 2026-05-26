extends Node2D


var overlay: AnimationPlayer
var carriage: AnimationPlayer
var driver: AnimationPlayer
var empty: Sprite2D

var hasDriver: bool = false
var hasHorses: bool = false
var horsesEating: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    overlay = get_node("overlay")
    carriage = get_node("back")
    driver = get_node("driver")
    empty = get_node("horseless")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    overlay.frame = carriage.frame
    overlay.frame_time = carriage.frame_time

