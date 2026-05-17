extends Node2D

var scene: PackedScene
var textures: Array[CompressedTexture2D]
var lastCloudTime: float = 0
var cloudScale: float = 1
var cloudSpeed: float = 100
var cloudGap: float = 500
var cloudLeft: float = -2000
var cloudRight: float = 6000

var clouds: int = 0
var label: Label

func _ready() -> void:
	scene = preload("res://assets/clouds/cloud.tscn")
	textures = [
		preload("res://assets/clouds/cloud1.png"),
		preload("res://assets/clouds/cloud2.png"),
		preload("res://assets/clouds/cloud3.png"),
		preload("res://assets/clouds/cloud4.png"),
		preload("res://assets/clouds/cloud5.png"),
		preload("res://assets/clouds/cloud6.png"),
	]
	cloudScale = get_meta("Scale")
	cloudSpeed = get_meta("Speed")
	cloudGap = get_meta("Gap")
	cloudLeft = get_meta("Left")
	cloudRight = get_meta("Right")

	label = get_node("label")

	prepopulate()


func instance_cloud() -> Node2D:
	var cloud = scene.instantiate()
	cloud.set_meta("Src", textures[randi() % textures.size()])
	cloud.position.x = -cloudLeft
	cloud.position.y = randi() % 100 - 50
	add_child(cloud)
	
	clouds += 1 

	return cloud

func prepopulate() -> void:
	for i in (cloudRight+cloudLeft) / cloudGap:
		var cloud = instance_cloud()
		cloud.position.x = i * cloudGap - cloudLeft


func _process(delta: float) -> void:
	lastCloudTime += delta * cloudSpeed
	if lastCloudTime > cloudGap:
		instance_cloud()
		lastCloudTime = 0
