CIRCLE_TILE_ID EQU $70

DisplayDiploma::
	call SaveScreenTilesToBuffer2
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	xor a
	ld [wUpdateSpritesEnabled], a
	ld hl, wd730
	set 6, [hl]
	call DisableLCD
	ld hl, CircleTile
	ld de, vChars2 + CIRCLE_TILE_ID * $10
	ld bc, $10
	ld a, BANK(CircleTile)
	call FarCopyData2
	coord hl, 0, 0
	lb bc, 16, 18
	predef Diploma_TextBoxBorder
	ld hl, DiplomaTextPointersAndCoords
	ld c, $5
.asm_56715
	push bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call PlaceString
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .asm_56715
	coord hl, 9, 6
	ld de, wPlayerName
	call PlaceString
	callba DrawPlayerCharacter

; Move the player 33 pixels right and set the priority bit so he appears
; behind the background layer.
	ld hl, wOAMBuffer + $01
	lb bc, $80, $28
.adjustPlayerGfxLoop
	ld a, [hl] ; X
	sub 76
	ld [hli], a
	inc hl
	ld a, b
	ld [hli], a ; attributes
	inc hl
	dec c
	jr nz, .adjustPlayerGfxLoop

	call EnableLCD
	callba LoadTrainerInfoTextBoxTiles
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	ld a, $90
	ld [rOBP0], a
	call WaitForTextScrollButtonPress
	ld hl, wd730
	res 6, [hl]
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call Delay3
	jp GBPalNormal

UnusedPlayerNameLengthFunc:
; Unused function that does a calculation involving the length of the player's
; name.
	ld hl, wPlayerName
	lb bc, $ff, $00
.loop
	ld a, [hli]
	cp "@"
	ret z
	dec c
	jr .loop

DiplomaTextPointersAndCoords:
	dw DiplomaText
	dwCoord 12, 2
	dw DiplomaPlayer
	dwCoord 13, 4
	dw DiplomaEmptyText
	dwCoord 5, 4
	dw DiplomaCongrats
	dwCoord 17, 6
	dw DiplomaGameFreak
	dwCoord 15, 14

DiplomaText:
	db CIRCLE_TILE_ID, "תעודה", CIRCLE_TILE_ID, "@"

DiplomaPlayer:
	db "ברכותינו!"

DiplomaEmptyText:
	text_end

DiplomaCongrats:
	db   "  לשחקן"
	next "וזאת לתעודה כי"
	next "השלמת את ה#ידע"
	next "שלך.@"

DiplomaGameFreak:
	db "על החתום,"
	next "    גיים פריק.@"