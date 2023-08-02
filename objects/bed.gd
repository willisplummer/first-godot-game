extends StaticBody2D

func interact():
	DialogueManager.start_dialogue(get_global_position(), ["Weird place for a bed", "I shouldnt.."])
