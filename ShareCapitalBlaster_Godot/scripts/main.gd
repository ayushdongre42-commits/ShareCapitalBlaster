
extends Node2D

const QUESTIONS = [
    {"q":"What is the maximum capital a company can raise called?", "opts":["Issued Capital","Authorised Capital","Subscribed Capital","Paid-up Capital"], "ans":1},
    {"q":"Which type of shares carry voting rights?", "opts":["Preference Shares","Equity Shares","Bonus Shares","Debentures"], "ans":1}
]

onready var question_label = $HUD/QuestionLabel
onready var timer_label = $HUD/TimerLabel
onready var enemies = $Enemies
onready var score_label = $HUD/ScoreLabel
var current = 0
var score = 0
var timeleft = 10
var timer_running = false

func _ready():
    show_question(current)

func show_question(idx):
    for child in enemies.get_children():
        child.queue_free()
    var data = QUESTIONS[idx]
    question_label.text = data.q
    timeleft = 10
    timer_label.text = str(timeleft) + "s"
    # spawn enemies as Labels falling with options
    for i in range(data.opts.size()):
        var lbl = Label.new()
        lbl.text = data.opts[i]
        lbl.name = "opt_%d" % i
        lbl.rect_position = Vector2(100 + i*180, -50)
        enemies.add_child(lbl)
    timer_running = true

func _process(delta):
    if timer_running:
        timeleft -= delta
        if timeleft <= 0:
            timer_running = false
            on_answer(-1) # time up -> wrong
        timer_label.text = str(int(ceil(timeleft))) + "s"
    # move enemies downward
    for child in enemies.get_children():
        child.rect_position.y += 100 * delta

func on_answer(selected):
    var correct = QUESTIONS[current].ans
    if selected == correct:
        score += 10
        score_label.text = "Score: %d" % score
        question_label.text = "Correct!"
    else:
        question_label.text = "Wrong or Time up!"
    current += 1
    if current >= QUESTIONS.size():
        question_label.text = "Congratulations Ayush Dongre! You completed the Share Capital Chapter! Score: %d" % score
        timer_label.hide()
        return
    yield(get_tree().create_timer(1.2), "timeout")
    show_question(current)
