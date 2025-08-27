
extends KinematicBody2D

export (PackedScene) var BulletScene
var speed = 400

func _physics_process(delta):
    var dir = Vector2()
    if Input.is_action_pressed("ui_right"):
        dir.x += 1
    if Input.is_action_pressed("ui_left"):
        dir.x -= 1
    move_and_collide(dir.normalized() * speed * delta)

func _input(event):
    if event.is_action_pressed("ui_select") or (event is InputEventMouseButton and event.pressed):
        shoot()

func shoot():
    var b = BulletScene.instance()
    b.position = position - Vector2(0,20)
    get_parent().add_child(b)
