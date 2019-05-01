extends Node2D

onready var demo1 = $demo1
onready var demo2 = $demo2
onready var demo3 = $demo3
onready var demo1_label = $demo1/Label1
onready var demo2_label = $demo2/Label2
onready var demo3_label = $demo3/Label3

func _ready():
	demo1.value = 0
	demo2.value = 0
	demo3.value = 0
	demo1_label.text = str(0)
	demo2_label.text = str(0)
	demo3_label.text = str(0)

func increase_or_reduce(whichobject, incorreduce):
	if whichobject == "demo1" and incorreduce == "inc":
		demo1.value += 1
		demo1_label.text = str(demo1.value)
	elif whichobject == "demo1" and incorreduce == "red":
		demo1.value -= 1
		demo1_label.text = str(demo1.value)
	if whichobject == "demo2" and incorreduce == "inc":
		demo2.value += 1
		demo2_label.text = str(demo2.value)
	elif whichobject == "demo2" and incorreduce == "red":
		demo2.value -= 1
		demo2_label.text = str(demo2.value)
	if whichobject == "demo3" and incorreduce == "inc":
		demo3.value += 1
		demo3_label.text = str(demo3.value)
	elif whichobject == "demo3" and incorreduce == "red":
		demo3.value -= 1
		demo3_label.text = str(demo3.value)