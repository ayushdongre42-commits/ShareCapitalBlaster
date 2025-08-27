
extends Area2D

var speed = 600

func _physics_process(delta):
    position.y -= speed * delta
    if position.y < -50:
        queue_free()

func _on_Area2D_body_entered(body):
    if body is Label:
        var name = body.name
        var parts = name.split("_")
        var idx = int(parts[1])
        get_node("/root/Main").on_answer(idx)
        body.queue_free()
        queue_free()
