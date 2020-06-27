_TM29PreReceiveText::
	text "חכי! אל"
	line "תגידי מילה..."

	para "את רצית בזה!"
	prompt

_ReceivedTM29Text::
	text "קיבלה את <PLAYER>"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_TM29ExplanationText::
	text "זה המהלך TM29" ;TODO
	line "אשליה!"

	para "זה מאפשר לך"
	line "להחליש את"
	cont "היכולות המיוחדות"
	cont "של היריב."
	done

_TM29NoRoomText::
	text "אין לך מקום"
	line "בשביל זה."
	done
