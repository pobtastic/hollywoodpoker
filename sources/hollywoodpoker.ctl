; Copyright Golden Games 1986, 2024 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @rom
> $4000 @org=$4000
b $4000 Loading Screen
D $4000 #UDGTABLE { =h Hollywood Poker Loading Screen. } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels.
  $5800,$0300,$20 Attributes.

b $5B00 Stack

c $5D3B Game Entry Point
@ $5D3B label=GameEntryPoint
  $5D3B,$03 Jump to #R$6E9D.

t $5D3E Messaging: Loader
@ $5D3E label=Messaging_Loader

b $5D90

c $6E9D Title Screen
@ $6E9D label=TitleScreen
  $6E9D,$06 #HTML(Write #R$6E9D to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3D.html">ERR_SP</a>.)
  $6EA3,$01 Decrease #REGhl by one.
  $6EA4,$01 Set the stack pointer to the address held by #REGhl.
  $6EA5,$03 Call #R$784B.
  $6EA8,$06 Highlight the currently selected menu item in #R$6F02.
  $6EAE,$03 Call #R$FB3A.
@ $6EB1 label=TitleScreen_Loop
  $6EB1,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
  $6EB4,$02,b$01 #REGa=#N$0F.
M $6EB4,$03 Mask off bits 4-7.
  $6EB7,$10 Jump to #R$6ECC if there is any input.
@ $6EC7 label=TitleScreenNoInput
  $6EC7,$03 Call #R$FB46.
  $6ECA,$02 Loop back around to #R$6EB1.
N $6ECC Handler directing the keypress to the appropriate routines.
@ $6ECC label=TitleScreenRouting
  $6ECC,$01 Fetch the user input.
  $6ECD,$04 Jump to #R$6EC7 if #REGe is #N$23.
  $6ED1,$04 Jump to #R$6F03 if "DEFINE KEYBOARD" was selected.
  $6ED5,$04 Jump to #R$6F10 if "KEMPSTON" was selected.
  $6ED9,$04 Jump to #R$6F1F if "CURSOR" was selected.
  $6EDD,$04 Jump to #R$6F2F if "SINCLAIR IF2" was selected.
  $6EE1,$04 Jump to #R$6F3F if "KEYBOARD" was selected.
  $6EE5,$05 Jump to #R$6F94 if "START GAME" was selected.
  $6EEA,$05 Jump to #R$73BE if "INFORMATION" was selected.
  $6EEF,$05 Jump to #R$704A if "WINNERS LIST" was selected.
N $6EF4 Else "9" was pressed which is "RETURN TO BASIC".
  $6EF4,$0E #HTML(Delete the game code and jump to
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0066.html">RESET</a>.)

g $6F02 Control Method
@ $6F02 label=ControlMethod
D $6F02 Will contain the following:
. #TABLE(default,centre,centre)
. { =h Byte | =h Meaning }
. { #N$01 | User-Defined Keys }
. { #N$02 | Kempston Joystick }
. { #N$03 | Cursor Keys/ Joystick }
. { #N$04 | Interface II Joystick }
. { #N$05 | Keyboard }
. TABLE#
B $6F02,$01

c $6F03 Title Screen: Define Keys Selected
@ $6F03 label=TitleScreen_DefineKeysSelected
  $6F03,$03 Call #R$6F77.
  $6F06,$02 #REGa=#N$01.
  $6F08,$03 Call #R$6F7B.
  $6F0B,$03 Call #R$6F9A.
  $6F0E,$02 Jump to #R$6F3F.

c $6F10 Title Screen: Kempston Selected
@ $6F10 label=TitleScreen_KempstonSelected
  $6F10,$03 Call #R$6F77.
  $6F13,$02 #REGa=#N$02.
  $6F15,$03 Call #R$6F7B.
  $6F18,$05 Write #N$06 to *#R$913E.
  $6F1D,$02 Jump to #R$6EC7.

c $6F1F Title Screen: Cursor Selected
@ $6F1F label=TitleScreen_CursorSelected
  $6F1F,$03 Call #R$6F77.
  $6F22,$02 #REGa=#N$03.
  $6F24,$03 Call #R$6F7B.
  $6F27,$03 #REGhl=#R$6F59.
  $6F2A,$03 Call #R$6F50.
  $6F2D,$02 Jump to #R$6EC7.

c $6F2F Title Screen: Sinclair IF2 Selected
@ $6F2F label=TitleScreen_SinclairIF2Selected
  $6F2F,$03 Call #R$6F77.
  $6F32,$02 #REGa=#N$04.
  $6F34,$03 Call #R$6F7B.
  $6F37,$03 #REGhl=#R$6F63.
  $6F3A,$03 Call #R$6F50.
  $6F3D,$02 Jump to #R$6EC7.

c $6F3F Title Screen: Keyboard Selected
@ $6F3F label=TitleScreen_KeyboardSelected
  $6F3F,$03 Call #R$6F77.
  $6F42,$02 #REGa=#N$05.
  $6F44,$03 Call #R$6F7B.
  $6F47,$03 #REGhl=#R$6F6D.
  $6F4A,$03 Call #R$6F50.
  $6F4D,$03 Jump to #R$6EC7.

c $6F50 Copy Keymap To Defined Keys
@ $6F50 label=SetDefinedKeys
R $6F50 HL Source address of keymaps to copy
  $6F50,$09 Copy the source keymap to #R$913E.

g $6F59 Cursor Keys Keymap
@ $6F59 label=CursorKeysKeymap
D $6F59 Used by the routine at #R$6F1F.
B $6F59,$02
L $6F59,$02,$05

g $6F63 Sinclair Interface 2 Keymap
@ $6F63 label=SinclairIF2Keymap
D $6F63 Used by the routine at #R$6F2F.
B $6F63,$02
L $6F63,$02,$05

g $6F6D Keyboard Keymap
@ $6F6D label=KeyboardKeymap
D $6F6D Used by the routine at #R$6F3F.
B $6F6D,$02
L $6F6D,$02,$05

g $6F6D

c $6F77 Clear Active Menu Item
@ $6F77 label=ClearActiveMenuItem
  $6F77,$02 #REGc=#INK$07.
  $6F79,$02 Jump to #R$6F80.

c $6F7B Highlight Menu Line
@ $6F7B label=HighlightMenuLine
R $6F7B A The active menu item number
  $6F7B,$02 #REGc=#INK$03.
  $6F7D,$03 Write #REGa to *#R$6F02.
@ $6F80 label=SetActiveMenuItem
  $6F80,$03 Fetch *#R$6F02.
N $6F83 Locate the desired line for highlighting.
  $6F83,$03 #REGhl=#N$58EB (attribute buffer location).
  $6F86,$03 #REGde=#N$20 (one line).
N $6F89 Keep moving down one line in relation to the active menu number.
@ $6F89 label=FindMenuLine
  $6F89,$01 #REGhl+=#REGde.
  $6F8A,$03 Decrease #REGa by one and jump back to #R$6F89 until the correct line is referenced.
N $6F8D Highlight the line.
  $6F8D,$02 Set a counter of #N$12 (the maximum number of characters on any line).
@ $6F8F label=HighlightMenuLine_Loop
  $6F8F,$01 Write the attribute byte to the currently referenced attribute buffer location.
  $6F90,$01 Increment the referenced attribute buffer location by one.
  $6F91,$02 Decrease the counter by one and loop back to #R$6F8F until the whole line is highlighted.
  $6F93,$01 Return.

c $6F94 Start Game
@ $6F94 label=StartGame
  $6F94,$03 Call #R$8CF0.
  $6F97,$03 Jump to #R$729A.

c $6F9A Collect User-Defined Keys
@ $6F9A label=CollectUserDefinedKeys
  $6F9A,$05 Write #N$01 to *#R$7049.
  $6F9F,$03 #REGhl=#R$6F6D.
  $6FA2,$02 #REGb=#N$05.
  $6FA4,$02 Write #N$00 to *#REGhl.
  $6FA6,$02 Increment #REGhl by two.
  $6FA8,$02 Decrease counter by one and loop back to #R$6FA4 until counter is zero.
  $6FAA,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
  $6FAD,$01 Increment #REGe by one.
  $6FAE,$02 Jump to #R$6FAA until #REGe is zero.
  $6FB0,$04 #HTML(Write #N$00 to <a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $6FB4,$02 #REGc=#N$05.
  $6FB6,$03 Call #R$7035.
  $6FB9,$03 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/02BF.html">KEYBOARD</a>.)
  $6FBC,$04 Test bit 5 of *#REGix+#N$01.
  $6FC0,$02 Jump to #R$6FB9 if {} is zero.
  $6FC2,$03 #HTML(#REGa=*<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $6FC5,$04 Jump to #R$6FDD if #REGa is equal to #N$0D.
  $6FC9,$04 Jump to #R$6FDD if #REGa is equal to #N$20.
  $6FCD,$04 Jump to #R$6FB9 if #REGa is lower than #N$30.
  $6FD1,$04 Jump to #R$6FB9 if #REGa is higher than #N$5B.
  $6FD5,$04 Jump to #R$6FDD if #REGa is higher than #N$41.
  $6FD9,$04 Jump to #R$6FB9 if #REGa is higher than #N$3A.
  $6FDD,$03 #REGhl=#R$6F6D.
  $6FE0,$01 #REGd=#REGa.
  $6FE1,$02 #REGb=#N$05.
  $6FE3,$04 Jump to #R$6FB9 if *#REGhl is equal to #REGd.
  $6FE7,$02 Increment #REGhl by two.
  $6FE9,$02 Decrease counter by one and loop back to #R$6FE3 until counter is zero.
  $6FEB,$04 #REGb=*#R$7049.
  $6FEF,$03 #REGhl=#R$6F6B.
  $6FF2,$02 Increment #REGhl by two.
  $6FF4,$02 Decrease counter by one and loop back to #R$6FF2 until counter is zero.
  $6FF6,$01 Write #REGd to *#REGhl.
  $6FF7,$01 Stash #REGde on the stack.
  $6FF8,$01 #REGb=#REGa.
  $6FF9,$02 #REGa=#N$18.
  $6FFB,$01 #REGa-=#REGb.
  $6FFC,$01 #REGb=#REGa.
  $6FFD,$02 #REGc=#N$0B.
  $6FFF,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DD9.html#0DE2">#N$0DE2</a> (CL_SET).)
  $7002,$01 Restore #REGde from the stack.
  $7003,$01 #REGa=#REGd.
  $7004,$04 Jump to #R$702D if #REGa is equal to #N$0D.
  $7008,$04 Jump to #R$7025 if #REGa is equal to #N$20.
  $700D,$02 #REGb=#N$04.
  $700F,$02 #REGa=#N$20.
  $7012,$02 Decrease counter by one and loop back to #R$700F until counter is zero.
  $7014,$02 #REGc=#N$07.
  $7016,$03 Call #R$7035.
  $7019,$03 #REGa=*#R$7049.
  $701C,$01 Increment #REGa by one.
  $701D,$03 Write #REGa to *#R$7049.
  $7020,$04 Jump to #R$6FB4 if #REGa is not equal to #N$06.
  $7024,$01 Return.

  $7025,$03 #REGhl=#R$7A41.
  $7028,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $702B,$02 Jump to #R$700D.
  $702D,$03 #REGhl=#R$7A47.
  $7030,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $7033,$02 Jump to #R$700D.
  $7035,$03 #REGhl=#N$580B (attribute buffer location).
  $7038,$03 #REGde=#N($0020,$04,$04).
  $703B,$03 #REGa=*#R$7049.
  $703E,$01 #REGhl+=#REGde.
  $703F,$01 Decrease #REGa by one.
  $7040,$02 Jump to #R$703E until #REGa is zero.
  $7042,$02 #REGb=#N$14.
  $7044,$01 Write #REGc to *#REGhl.
  $7045,$01 Increment #REGhl by one.
  $7046,$02 Decrease counter by one and loop back to #R$7044 until counter is zero.
  $7048,$01 Return.
B $7049,$01

c $704A Display Winners List Page
@ $704A label=DisplayWinnersListPage
D $704A #PUSHS #POKES$5C36,$C9;$5C37,$F3 #UDGTABLE(default,centre)
. { #SIM(start=$704A,stop=$7066)#SCR$02(winners-list) }
. UDGTABLE# #POPS
. Used by the routines at #R$6ECC and #R$729A.
  $704A,$05 #HTML(Write #INK$07 to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C8D.html">ATTR_P</a>.)
  $704F,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DAF.html">CL_ALL</a>.)
  $7052,$0B Copy #N$1B00 bytes of data from the Spectrum ROM (literally from #N($0000,$04,$04) to the screen.
  $705D,$03 #REGde=#R$7073.
  $7063,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1FFC.html#203C">PR_STRING</a>.)

  $706A,$03 #REGbc=#N($0000,$04,$04).
  $706D,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1F3A.html#1F3D">PAUSE_1</a>.)
  $7070,$03 Jump to #R$6E9D.

t $7073 Messaging: Winners List
@ $7073 label=Messaging_WinnersList
D $7073 Used by the routine at #R$704A.
B $7073,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7076,$1A "#STR(#PC,$04,$1A)".
B $7090,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7093,$1A "#STR(#PC,$04,$1A)".
B $70AD,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $70B0,$1A "#STR(#PC,$04,$1A)".
B $70CA,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $70CD,$1A "#STR(#PC,$04,$1A)".
B $70E7,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $70EA,$1A "#STR(#PC,$04,$1A)".
B $7104,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7107,$1A "#STR(#PC,$04,$1A)".
B $7121,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7124,$1A "#STR(#PC,$04,$1A)".
B $713E,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7141,$1A "#STR(#PC,$04,$1A)".
B $715B,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $715E,$1A "#STR(#PC,$04,$1A)".
B $7178,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $717B,$1A "#STR(#PC,$04,$1A)".
B $7195,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7198,$1A "#STR(#PC,$04,$1A)".
B $71B2,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $71B5,$1A "#STR(#PC,$04,$1A)".
B $71CF,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $71D2,$1A "#STR(#PC,$04,$1A)".
B $71EC,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $71EF,$1A "#STR(#PC,$04,$1A)".
B $7209,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $720C,$1A "#STR(#PC,$04,$1A)".
B $7226,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7229,$1A "#STR(#PC,$04,$1A)".
B $7243,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7246,$1A "#STR(#PC,$04,$1A)".
B $7260,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7263,$1A "#STR(#PC,$04,$1A)".
B $727D,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7280,$1A "#STR(#PC,$04,$1A)".

c $729A
N $729A Debounce the key press.
@ $729A label=Debounce_Loop
  $729A,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
N $729D Handle if no keys are being pressed, for reference:
N $729D #HTML(<blockquote>In all instances the #REGe register is returned with
. a value in the range of +#N$00 to +#N$27, the value being different for each
. of the forty keys of the keyboard, or the value +#N$FF, for no-key.</blockquote>)
  $729D,$01 Set the zero flag if no keys have been pressed.
  $729E,$02 Jump to #R$729A unless no keys are being pressed.
  $72A0,$03 #REGa=*#R$98E3.
  $72A3,$02 Set a counter of #N$08.
  $72A5,$03 #REGhl=#R$7368.
  $72A8,$01 Copy *#R$98E3 into #REGd.
  $72A9,$04 Jump to #R$72B5 if *#REGhl is lower than #REGd.
  $72AD,$03 Increment #REGhl by three.
  $72B0,$02 Decrease counter by one and loop back to #R$72A9 until counter is zero.
  $72B2,$03 Jump to #R$6E9D.
  $72B5,$02 Stash #REGbc and #REGhl on the stack.
  $72B7,$03 #REGhl=#R$7399.
  $72BA,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $72BD,$03 #REGhl=#R$7383.
  $72C0,$02 Set a counter of #N$16 which is the maximum length of the name entry buffer.
@ $72C2 label=Clear_NameEntryBuffer_Loop
  $72C2,$02 Write an ASCII "SPACE" (#N$20) to *#REGhl.
  $72C4,$01 Increment #REGhl by one.
  $72C5,$02 Decrease counter by one and loop back to #R$72C2 until counter is zero.
  $72C7,$04 Write #N$00 to *#R$7336.
  $72CB,$03 #REGhl=#R$7383.
  $72CE,$02 #REGb=#N$0D.
  $72D0,$02 Stash #REGbc and #REGhl on the stack.
  $72D2,$04 Reset bit 5 of *#REGix+#N$01.
  $72D6,$03 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/02BF.html">KEYBOARD</a>.)
  $72D9,$04 Test bit 5 of *#REGix+#N$01.
  $72DD,$02 Jump to #R$72D2 if {} is zero.
  $72DF,$07 #HTML(Jump to #R$7337 if *<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed) is equal to #N$0D.)
  $72E6,$04 #HTML(Jump to #R$7310 if *<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed) is equal to #N$0C.)
  $72EA,$01 #REGb=#REGa.
  $72EB,$06 Jump to #R$72D2 if *#R$7336 is not zero.
  $72F1,$05 Jump to #R$72D2 if #REGb is lower than #N$20.
  $72F6,$04 Jump to #R$72D2 if #REGb is higher than #N$7B.
  $72FA,$01 Restore #REGhl from the stack.
  $72FB,$01 Stash #REGhl on the stack.
  $72FC,$01 Write #REGa to *#REGhl.
  $72FE,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
N $72FE Handle if no keys are being pressed, for reference:
N $72FE #HTML(<blockquote>In all instances the #REGe register is returned with
. a value in the range of +#N$00 to +#N$27, the value being different for each
. of the forty keys of the keyboard, or the value +#N$FF, for no-key.</blockquote>)
  $7301,$01 Set the zero flag if no keys have been pressed.
  $7302,$02 Jump to #R$72FE unless no keys are being pressed.
  $7304,$02 Restore #REGhl and #REGbc from the stack.
  $7306,$01 Increment #REGhl by one.
  $7307,$02 Decrease counter by one and loop back to #R$72D0 until counter is zero.
  $7309,$05 Write #N$01 to *#R$7336.
  $730E,$02 Jump to #R$72D0.
  $7310,$02 Restore #REGhl and #REGbc from the stack.
  $7312,$04 Write #N$00 to *#R$7336.
  $7316,$05 Jump to #R$72D0 if #REGb is equal to #N$0D.
  $731B,$01 Decrease #REGhl by one.
  $731C,$02 Write #N$20 to *#REGhl.
  $731E,$03 Backspace.
  $7321,$03 Print "SPACE".
  $7324,$03 Backspace.
  $7327,$01 Increment #REGb by one.
  $7328,$02 Stash #REGbc and #REGhl on the stack.
  $732A,$04 Reset bit 5 of *#REGix+#N$01.
  $732E,$03 #REGbc=#N($0000,$04,$04).
  $7331,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1F3A.html#1F3D">PAUSE_1</a>.)
  $7334,$02 Jump to #R$72D2.
B $7336,$01
  $7337,$04 Restore #REGhl, #REGbc, #REGhl and #REGbc from the stack.
  $733B,$01 #REGe=#REGb.
  $733C,$01 #REGa=*#REGhl.
  $733D,$01 Write #REGd to *#REGhl.
  $733E,$03 Increment #REGhl by three.
  $7341,$01 #REGd=#REGa.
  $7342,$02 Decrease counter by one and loop back to #R$733C until counter is zero.
  $7344,$01 #REGa=#REGe.
  $7345,$04 #REGix=#R$7381(#N$7382).
  $7349,$03 #REGh=*#REGix+#N$00.
  $734C,$03 #REGl=*#REGix-#N$01.
  $734F,$03 #REGd=*#REGix-#N$03.
  $7352,$03 #REGe=*#REGix-#N$04.
  $7355,$02 #REGb=#N$16.
  $7357,$01 Stash #REGaf on the stack.
  $7358,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/343C.html#343E">SWAP_BYTE</a>.)
  $735B,$06 Decrease #REGix by three.
  $7361,$01 Restore #REGaf from the stack.
  $7362,$01 Decrease #REGa by one.
  $7363,$02 Jump to #R$7349 until #REGa is zero.
  $7365,$03 Jump to #R$704A.

b $7368
  $7368,$01
W $7369,$02
L $7368,$03,$08
  $7380,$01

g $7381 Name Entry Buffer Pointer
@ $7381 label=Reference_NameEntry
W $7381,$02

t $7383 Name Entry Buffer
@ $7383 label=Buffer_NameEntry
  $7383,$16

t $7399 Messaging: Your Name
@ $7399 label=Messaging_YourName
B $7399,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $739C,$1E,$0F "#STR(#PC,$04,$1E)".
B $73BA,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $73BD,$01 Print "ENTER".

c $73BE Display Information Pages
@ $73BE label=DisplayInformationPages
D $73BE #PUSHS #POKES$5C36,$C9;$5C37,$F3 #UDGTABLE(default,centre)
. { #SIM(start=$73BE,stop=$73D7)#SCR$02(information-screen-1) |
.   #SIM(start=$73E1,stop=$73ED)#SCR$02(information-screen-2) }
. UDGTABLE# #POPS
. Used by the routine at #R$6ECC.
  $73BE,$08 #HTML(Write #INK$07 to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C48.html">BORDCR</a> and *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C8D.html">ATTR_P</a>.)
  $73C6,$05 #HTML(Set the border to #INK$00 using <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/2294.html#229b">BORDER</a>.)
  $73CB,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DAF.html">CL_ALL</a>.)
  $73CE,$03 #REGde=#R$73FA.
  $73D1,$03 #REGbc=#N$0283.
  $73D4,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1FFC.html#203C">PR_STRING</a>.)

  $73DB,$03 #REGbc=#N($0000,$04,$04).
  $73DE,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1F3A.html#1F3D">PAUSE_1</a>.)
  $73E1,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DAF.html">CL_ALL</a>.)
  $73E4,$03 #REGde=#R$767D.
  $73E7,$03 #REGbc=#N$0122.
  $73EA,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1FFC.html#203C">PR_STRING</a>.)

  $73F1,$03 #REGbc=#N($0000,$04,$04).
  $73F4,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1F3A.html#1F3D">PAUSE_1</a>.)
  $73F7,$03 Jump to #R$6E9D.

t $73FA Messaging: Information Page 1
@ $73FA label=Messaging_InformationPage1
D $73FA Used by the routine at #R$73BE.
B $73FA,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $73FD,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $73FF,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
  $7401,$1E "#STR(#PC,$04,$1E)".
B $741F,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $7422,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $7424,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $7426,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
  $7428,$0F "#STR(#PC,$04,$0F)".
B $7437,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $743A,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $743C,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $743E,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
  $7440,$1A "#STR(#PC,$04,$1A)".
B $745A,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $745D,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $745F,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $7461,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
  $7463,$20 "#STR(#PC,$04,$20)".
B $7483,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $7486,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $7488,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $748A,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
  $748C,$1A "#STR(#PC,$04,$1A)".
B $74A6,$01 BACKSPACE.
  $74A7,$01 "#STR(#PC,$04,$01)".
L $74A6,$02,$EB

t $767D Messaging: Information Page 2
@ $767D label=Messaging_InformationPage2
D $767D Used by the routine at #R$73BE.
  $767D,$20
L $767D,$20,$09

c $779F Life Lost
@ $779F label=LifeLost
  $779F,$01 Disable interrupts.
  $77A0,$03 #REGi=#N$00.
  $77A3,$02 #REGc=#N$03.
  $77A5,$02 #REGb=#N$00.
  $77A7,$01 #REGa=#N$00.
  $77A8,$02
  $77AA,$03 Decrease #REGa by one and jump back to #R$77A8 until #REGa is zero.
  $77AD,$02 Decrease counter by one and loop back to #R$77A7 until counter is zero.
  $77AF,$03 Decrease #REGc by one and jump back to #R$77A5 until #REGc is zero.
  $77B2,$07 #HTML(Jump to #R$77C0 if *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C92.html#5CA6">MEMBOT</a> (mem-4+#N$02) is not zero.)
N $77B9 #UDGTABLE { #MESSAGE$08(message-08) } UDGTABLE#
  $77B9,$05 Call #R$7D97 using message block #N$08.
  $77BE,$01 Enable interrupts.
  $77BF,$01 Return.
  $77C0,$03 #REGhl=#R$E820.
  $77C3,$03 #REGde=#R$F4C8.
  $77C6,$02 Write #N$80 to *#REGhl.
  $77C8,$01 Increment #REGhl by one.
  $77C9,$01 Stash #REGhl on the stack.
  $77CA,$02 #REGhl-=#REGde (with carry).
  $77CC,$02 Jump to #R$77D1 if {} is zero.
  $77CE,$01 Restore #REGhl from the stack.
  $77CF,$02 Jump to #R$77C6.

c $77D1 Turn Off Theme Tune
@ $77D1 label=TurnOffThemeTune
N $77D1 Self-modifying code.
  $77D1,$01 Restore #REGhl from the stack.
  $77D2,$08 #HTML(Write <code>RET</code> (#N$C9) to; #LIST { #R$FB3A } { #R$FB46 } LIST#)
  $77DA,$01 Return.

w $77DB

c $784B Display Title Screen
@ $784B label=DisplayTitleScreen
N $784B #UDGTABLE { #PUSHS #SIM(start=$784B,stop=$7906)#SCR$02(title-screen) #POPS } UDGTABLE#
  $784B,$02 #REGa=#N$02.
  $784D,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1601.html">CHAN_OPEN</a>.)

  $7850,$05 #HTML(Set the border to #INK$04 using <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/2294.html#229b">BORDER</a>.)
N $785D Set the UDG graphics pointer.
  $785D,$06 #HTML(Write #R$F4C9(#N$F3C9) (#R$F4C9) to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)

  $7863,$02 #REGa=#COLOUR$27.
  $7865,$03 #HTML(Write #REGa to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C8D.html">ATTR_P</a>.)

  $7868,$02 #REGa=#COLOUR$20.
  $786A,$03 #HTML(Write #REGa to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C48.html">BORDCR</a>.)

  $786D,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DAF.html">CL_ALL</a>.)
N $7870 Draw three sections which are white on the left, and black on the right:
N $7870 #UDGTABLE { #PUSHS #SIM(start=$7863,stop=$7893)#SCR$02(empty-sections) #POPS } UDGTABLE#
N $7870 Set the point in the attribute buffer where the black sections will begin.
  $7870,$03 #REGhl=#N$5821 (attribute buffer location).
  $7873,$02 Set a counter for the three sections to paint.
@ $7875 label=TitleScreen_SectionLoop
  $7875,$01 Stash the section counter on the stack.
  $7876,$02 In each section there are six rows, so set another counter for this.
@ $7878 label=TitleScreen_RowLoop
  $7878,$02 The entire length of each row is #N$1E character blocks.
@ $787A label=TitleScreen_Row
  $787A,$03 Is the current position #N$17 ... This is the split for white/ black.
  $787D,$02 #REGa=#COLOUR$78.
  $787F,$02 Jump to #R$7883 if the current position was #N$17 on line #R$787A.
  $7881,$02 #REGa=#COLOUR$07.
@ $7883 label=TitleScreen_Paint
  $7883,$01 Write the attribute byte to the pointer held in #REGhl.
  $7884,$01 Increment the attribute buffer pointer by one.
  $7885,$02 Decrease the length counter by one and loop back to #R$787A until the counter is zero.
  $7887,$02 Increment the attribute buffer pointer by two, this moves to the start of the next row.
  $7889,$03 Decrease the row counter by one and jump back to #R$7878 until all rows have been painted.
N $788C This section is now completely painted so move onto the next one.
  $788C,$04 Move to the next section.
  $7890,$01 Restore the section counter from the stack.
  $7891,$02 Decrease the section counter by one and loop back to #R$7875 until all three sections have been painted.
N $7893 Now print the icons in each box:
N $7893 #UDGTABLE { #PUSHS #SIM(start=$7863,stop=$7893)#SIM(start=$7893,stop=$78C1)#SCR$02(options) #POPS } UDGTABLE#
  $7893,$03 Set a pointer in #REGde where the icon graphics begin: #R$7A4D.
N $7896 Set up printing the keyboard icon.
  $7896,$03 #REGhl=#N$4021 (screen buffer location).
  $7899,$03 #REGbc=#N$0830 (width/ length).
  $789C,$01 Stash the width/ length on the stack.
  $789D,$03 Call #R$993A.
  $78A0,$01 Restore the width/ length from the stack.
  $78A1,$03 #REGhl=#N$5821 (attribute buffer location).
  $78A4,$03 Call #R$7917.
N $78A7 Set up printing the joystick icon.
  $78A7,$03 #REGhl=#N$4801 (screen buffer location).
  $78AA,$03 #REGbc=#N$0828 (width/ length).
  $78AD,$03 Call #R$993A.
N $78B0 Set up printing the information icon.
  $78B0,$03 #REGhl=#N$48E4 (screen buffer location).
  $78B3,$03 #REGbc=#N$0228 (width/ length).
  $78B6,$01 Stash the width/ length on the stack.
  $78B7,$03 Call #R$993A.
  $78BA,$01 Restore the width/ length from the stack.
  $78BB,$03 #REGhl=#N$59E4 (attribute buffer location).
  $78BE,$03 Call #R$7917.
N $78C1 Now handle printing the text.
  $78C1,$03 #REGde=#R$7931.
  $78C4,$03 #REGbc=#N($00C7,$04,$04).
  $78C7,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1FFC.html#203C">PR_STRING</a>.)
  $78CA,$02 #REGa=#N$01.
  $78CC,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1601.html">CHAN_OPEN</a>.)
  $78CF,$03 #REGhl=#R$79F8.
  $78D2,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $78D5,$02 #REGa=#N$02.
  $78D7,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1601.html">CHAN_OPEN</a>.)
N $78DA Lastly, print the current user-defined keys.
  $78DA,$03 #REGhl=#R$6F6D.
  $78DD,$03 #REGbc=#N$170B.
@ $78E0 label=PrintKeys_Loop
  $78E0,$02 Stash #REGbc and #REGhl on the stack.
  $78E2,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DD9.html#0DE2">#N$0DE2</a> (CL_SET).)
  $78E5,$06 Set INK: #INK$07.
  $78EB,$05 Set PAPER: #INK$00.
  $78F0,$01 Restore #REGhl from the stack.
  $78F1,$01 Stash #REGhl on the stack.
  $78F2,$01 #REGa=*#REGhl.
  $78F3,$04 Jump to #R$7907 if the key is "enter".
  $78F7,$04 Jump to #R$790F if the key is an ASCII "space".
  $78FB,$01 Print the key to the screen.
@ $78FC label=PrintKeys_Next
  $78FC,$01 Restore #REGhl from the stack.
  $78FD,$02 Increment #REGhl by two.
  $78FF,$01 Restore #REGbc from the stack.
  $7900,$01 Decrease #REGb by one.
  $7901,$05 Jump back to #R$78E0 until #REGb is equal to #N$12.
  $7906,$01 Return.
N $7907 Prints the word "ENTER".
@ $7907 label=PrintEnter
  $7907,$03 #REGhl=#R$7A47.
  $790A,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $790D,$02 Jump to #R$78FC.
N $790F Prints the word "SPACE".
@ $790F label=PrintSpace
  $790F,$03 #REGhl=#R$7A41.
  $7912,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $7915,$02 Jump to #R$78FC.

c $7917 Write Attribute Data
@ $7917 label=WriteAttributeData
R $7917 DE Attribute data
R $7917 HL Attribute buffer location
R $7917 B Width
R $7917 C Length
  $7917,$06
@ $791D label=WriteAttributeData_Loop
  $791D,$02 Stash #REGhl and #REGbc on the stack.
@ $791F label=WriteAttributeData_CopyLoop
  $791F,$02 Copy a byte from the source address to the destination address in
. the attribute buffer.
  $7921,$02 Increment both the source and destination addresses.
  $7923,$02 Decrease the width counter by one and loop back to #R$791F until the counter is zero.
  $7925,$02 Restore #REGbc and #REGhl from the stack.
  $7927,$01 Stash #REGde on the stack.
  $7928,$04 #REGhl+=#N($0020,$04,$04).
  $792C,$01 Restore #REGde from the stack.
  $792D,$03 Decrease the height counter by one and jump back to #R$791D until the counter is zero.
  $7930,$01 Return.

t $7931 Messaging: Title Screen
@ $7931 label=Messaging_TitleScreen
B $7931,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $7933,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $7935,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
B $7937,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $793A,$04 "#STR(#PC,$04,$04)".
B $793E,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7941,$05 "#STR(#PC,$04,$05)".
B $7946,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7949,$04 "#STR(#PC,$04,$04)".
B $794D,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7950,$02 "#STR(#PC,$04,$02)".
B $7952,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7955,$06 "#STR(#PC,$04,$06)".
B $795B,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $795E,$12 "#STR(#PC,$04,$12)".
B $7970,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7973,$0B "#STR(#PC,$04,$0B)".
B $797E,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7981,$0E "#STR(#PC,$04,$0E)".
B $798F,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7992,$0F "#STR(#PC,$04,$0F)".
B $79A1,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $79A4,$0B "#STR(#PC,$04,$0B)".
B $79AF,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $79B2,$0D "#STR(#PC,$04,$0D)".
B $79BF,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $79C2,$0F "#STR(#PC,$04,$0F)".
B $79D1,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $79D4,$0F "#STR(#PC,$04,$0F)".
B $79E3,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $79E6,$12 "#STR(#PC,$04,$12)".

t $79F8 Messaging: Footer Copyright
@ $79F8 label=Messaging_FooterCopyright
B $79F8,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $79FA,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $79FC,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
B $79FE,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7A01,$1E "#STR(#PC,$04,$1E)".
B $7A1F,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7A22,$1E "#STR(#PC,$04,$1E)".
B $7A40,$01 Print "ENTER".

t $7A41 Messaging: Space
@ $7A41 label=Messaging_Space
  $7A41,$06,$05:$01 "#STR(#PC,$04,$05)".

t $7A47 Messaging: Enter
@ $7A47 label=Messaging_Enter
  $7A47,$06,$05:$01 "#STR(#PC,$04,$05)".

b $7A4D Graphics: Keyboard Icon
@ $7A4D label=Graphics_KeyboardIcon
D $7A4D Used by the routine at #R$784B.
N $7A4D #UDGTABLE
. { #UDGARRAY$08,scale=$04,step=$08($7A4D-$7BC5-$01-$40)@$7BCD-$7BFC(keyboard) }
. UDGTABLE#
  $7A4D,$0180,$08 Pixels.
  $7BCD,$30,$08 Attributes.

b $7BFD Graphics: Joystick Icon
@ $7BFD label=Graphics_JoystickIcon
D $7BFD Used by the routine at #R$784B.
N $7BFD #UDGTABLE
. { #UDGARRAY$08,attr=$78,scale=$04,step=$08($7BFD-$7D25-$01-$40)(joystick) }
. UDGTABLE#
  $7BFD,$140,$08 Pixels.

b $7D3D Graphics: Information Icon
@ $7D3D label=Graphics_InformationIcon
D $7D3D Used by the routine at #R$784B.
N $7D3D #UDGTABLE
. { #UDGARRAY$02,scale=$04,step=$02($7D3D-$7D8B-$01-$10)@$7D8D-$7D96(information) }
. UDGTABLE#
  $7D3D,$50,$02 Pixels.
  $7D8D,$0A,$02 Attributes.

c $7D97 Messaging: Girl
@ $7D97 label=Messaging_Girl
R $7D97 A Message ID
N $7D97 #N$13 is the highest message ID.
  $7D97,$03 Write #REGa to *#R$8CEF.
  $7D9A,$03 Return if #REGa is higher than #N$13.
  $7D9D,$01 Increment #REGa by one.
  $7D9E,$03 #REGhl=#R$8CB1(#N$8CAE) (i.e. #R$8CB1-#N$03).
N $7DA1 Find the relevant message block.
@ $7DA1 label=FindMessagingBlock
  $7DA1,$03 Increment #REGhl by three.
  $7DA4,$03 Decrease #REGa by one and keep jumping back to #R$7DA1 until it is zero.
  $7DA7,$03 Load the referenced message block into #REGde.
  $7DAA,$02 Load the number of messages in this message block into #REGa.
  $7DAC,$03 Write the number of messages in this message block to *#R$8CEA.
  $7DAF,$04 Write #REGde to *#R$8CEB.
  $7DB3,$04 Write #REGde to *#R$8CED.
  $7DB7,$01 #REGb=the number of messages in this message block.
  $7DB8,$03 Call #R$9579.
  $7DBB,$04 Jump to #R$7DD6 if #REGa is lower than #N$0A.
  $7DBF,$07 #REGhl=*#R$8CED+#N($0036,$04,$04).
  $7DC6,$03 Write #REGhl to *#R$8CED.
  $7DC9,$02 Decrease counter by one and loop back to #R$7DB8 until counter is zero.
  $7DCB,$06 Write *#R$8CEB to *#R$8CED.
  $7DD1,$03 #REGa=*#R$8CEA.
  $7DD4,$02 Jump to #R$7DB7.
  $7DD6,$01 #REGa=#N$00.
  $7DD7,$01 Stash #REGaf on the stack.
  $7DD8,$05 Set INK: #INK$00.
  $7DDD,$06 Set PAPER: #INK$07.
  $7DE3,$09 PRINT AT: #N$00#RAW(,) #N$0D.
  $7DEC,$06 BRIGHT: ON.
  $7DF2,$04 #REGde=*#R$8CED.
  $7DF6,$03 #REGbc=#N($000E,$04,$04).
  $7DF9,$01 Restore #REGaf from the stack.
  $7DFA,$02 Compare #REGa with #N$03.
  $7DFC,$01 Stash #REGaf on the stack.
  $7DFD,$02 Jump to #R$7E01 if {} is not zero.
  $7DFF,$02 Decrease #REGbc by two.
  $7E01,$03 Call #R$F7CA.
  $7E04,$04 Write #REGde to *#R$8CED.
  $7E08,$01 Restore #REGaf from the stack.
  $7E09,$04 Jump to #R$7E10 if #REGa is equal to #N$03.
  $7E0D,$01 Increment #REGa by one.
  $7E0E,$02 Jump to #R$7DD7.
  $7E10,$07 Jump to #R$7E1D if *#R$8CEF is equal to #N$11.
  $7E17,$04 Jump to #R$7E1D if *#R$8CEF is equal to #N$0F.
  $7E1B,$02 Jump to #R$7E22.
  $7E1D,$05 Write #N$00 to *#R$92C5.
  $7E22,$03 Call #R$90D8.
  $7E25,$04 Jump to #R$7E22 if #REGa is higher than #N$05.
  $7E29,$07 Jump to #R$7E6B if *#R$8CEF is not equal to #N$12.
  $7E30,$03 #REGhl=#N$5800 (screen buffer location).
  $7E33,$03 #REGde=#N$583F (attribute buffer location).
  $7E36,$02 #REGc=#N$20.
  $7E38,$02 Stash #REGhl and #REGde on the stack.
  $7E3A,$02 #REGb=#N$06.
  $7E3C,$01 #REGa=#N$00.
  $7E3D,$02 Write #N$00 to *#REGhl.
  $7E3F,$01 Write #REGa to *#REGde.
  $7E40,$01 Stash #REGde on the stack.
  $7E41,$04 #REGhl+=#N($0040,$04,$04).
  $7E45,$03 #REGix=#REGhl (using the stack).
  $7E48,$01 Restore #REGhl from the stack.
  $7E49,$01 #REGhl+=#REGde.
  $7E4A,$01 Exchange the #REGde and #REGhl registers.
  $7E4B,$03 #REGhl=#REGix (using the stack).
  $7E4E,$02 Decrease counter by one and loop back to #R$7E3C until counter is zero.
  $7E50,$02 #REGa=#N$0E.
  $7E52,$02 Decrease counter by one and loop back to #R$7E52 until counter is zero.
  $7E54,$01 Decrease #REGa by one.
  $7E55,$02 Jump to #R$7E52 until #REGa is zero.
  $7E57,$02 Restore #REGde and #REGhl from the stack.
  $7E59,$01 Increment #REGhl by one.
  $7E5A,$01 Decrease #REGde by one.
  $7E5B,$01 Decrease #REGc by one.
  $7E5C,$02 Jump to #R$7E38 until #REGc is zero.

N $7E5E Count to #N$50000 to give the player a chance to read the messaging.
  $7E5E,$02 Set a counter for #N$05 loops.
@ $7E60 label=Messaging_Girl_PauseLoop
  $7E60,$03 #REGhl=#N($0000,$04,$04).
@ $7E63 label=Messaging_Girl_InnerPauseLoop
  $7E63,$01 Decrease #REGhl by one.
  $7E64,$04 Loop back to #R$7E63 until #REGhl is zero.
  $7E68,$02 Decrease the counter by one and loop back to #R$7E60 until the counter is zero.
  $7E6A,$01 Return.

c $7E6B Remove Speech Bubble
@ $7E6B label=RemoveSpeechBubble
D $7E6B #PUSHS #UDGTABLE
. { #SIM(start=$7E6B,stop=$7E8E)#SCR$02{$D0,$00,$70,$40}(couch) }
. UDGTABLE# #POPS
. Used by the routine at #R$7D97.
  $7E6B,$03 Set the source address as #R$9726.
  $7E6E,$03 Set the destination address in the screen buffer to #N$400D.
  $7E71,$02 #REGb=#N$07 (width).
  $7E73,$02 #REGc=#N$20 (height).
  $7E75,$03 Call #R$993A.
N $7E78 Recolour the background.
  $7E78,$03 #REGhl=#N$580D (attribute buffer location).
  $7E7B,$02 #REGc=#N$04 (height in character blocks).
@ $7E7D label=RemoveSpeechBubble_RowLoop
  $7E7D,$02 #REGb=#N$07 (width).
@ $7E7F label=RemoveSpeechBubble_Loop
  $7E7F,$02 Copy one byte of attribute data to the attribute buffer.
  $7E81,$01 Increment the source attribute data pointer by one.
  $7E82,$01 Increment the attribute buffer pointer by one.
  $7E83,$02 Decrease the counter by one and loop back to #R$7E7F until the counter is zero.
  $7E85,$01 Briefly stash #REGde on the stack.
  $7E86,$04 Add #N($0019,$04,$04) to #REGhl to move onto the next row.
  $7E8A,$01 Restore #REGde from the stack.
  $7E8B,$03 Decrease the counter by one and jump back to #R$7E7D until the counter is zero.
  $7E8E,$01 Return.

t $7E8F Message Block: #N$00
@ $7E8F label=MessageBlock_00
N $7E8F Message: #N($01+(#PC-$7E8F)/$36).
  $7E8F,$36,$0E
L $7E8F,$36,$05

t $7F9D Message Block: #N$01
@ $7F9D label=MessageBlock_01
N $7F9D Message: #N($01+(#PC-$7F9D)/$36).
  $7F9D,$36,$0E
L $7F9D,$36,$05

t $80AB Message Block: #N$02
@ $80AB label=MessageBlock_02
N $80AB Message: #N($01+(#PC-$80AB)/$36).
  $80AB,$36,$0E
L $80AB,$36,$05

t $81B9 Message Block: #N$03
@ $81B9 label=MessageBlock_03
N $81B9 Message: #N($01+(#PC-$81B9)/$36).
  $81B9,$36,$0E
L $81B9,$36,$03

t $825B Message Block: #N$04
@ $825B label=MessageBlock_04
N $825B Message: #N($01+(#PC-$825B)/$36).
  $825B,$36,$0E
L $825B,$36,$05

t $8369 Message Block: #N$05
@ $8369 label=MessageBlock_05
N $8369 Message: #N($01+(#PC-$8369)/$36).
  $8369,$36,$0E
L $8369,$36,$05

t $8477 Message Block: #N$06
@ $8477 label=MessageBlock_06
N $8477 Message: #N($01+(#PC-$8477)/$36).
  $8477,$36,$0E
L $8477,$36,$05

t $8585 Message Block: #N$07
@ $8585 label=MessageBlock_07
N $8585 Message: #N($01+(#PC-$8585)/$36).
  $8585,$36,$0E

t $85BB Message Block: #N$08
@ $85BB label=MessageBlock_08
N $85BB Message: #N($01+(#PC-$85BB)/$36).
  $85BB,$36,$0E
L $85BB,$36,$04

t $8693 Message Block: #N$09
@ $8693 label=MessageBlock_09
N $8693 Message: #N($01+(#PC-$8693)/$36).
  $8693,$36,$0E
L $8693,$36,$03

t $8735 Message Block: #N$0A
@ $8735 label=MessageBlock_10
N $8735 Message: #N($01+(#PC-$8735)/$36).
  $8735,$36,$0E
L $8735,$36,$05

t $8843 Message Block: #N$0B
@ $8843 label=MessageBlock_11
N $8843 Message: #N($01+(#PC-$8843)/$36).
  $8843,$36,$0E
L $8843,$36,$03

t $891B Message Block: #N$0C
@ $891B label=MessageBlock_12
N $891B Message: #N($01+(#PC-$891B)/$36).
  $891B,$36,$0E

t $88E5 Message Block: #N$0D
@ $88E5 label=MessageBlock_13
N $88E5 Message: #N($01+(#PC-$88E5)/$36).
  $88E5,$36,$0E

t $8951 Message Block: #N$0E
@ $8951 label=MessageBlock_14
N $8951 Message: #N($01+(#PC-$8951)/$36).
  $8951,$36,$0E
L $8951,$36,$03

t $89F3 Message Block: #N$0F
@ $89F3 label=MessageBlock_15
N $89F3 Message: #N($01+(#PC-$89F3)/$36).
  $89F3,$36,$0E

t $8A29 Message Block: #N$10
@ $8A29 label=MessageBlock_16
N $8A29 Message: #N($01+(#PC-$8A29)/$36).
  $8A29,$36,$0E
L $8A29,$36,$06

t $8B6D Message Block: #N$11
@ $8B6D label=MessageBlock_17
N $8B6D Message: #N($01+(#PC-$8B6D)/$36).
  $8B6D,$36,$0E
L $8B6D,$36,$03

t $8C0F Message Block: #N$12
@ $8C0F label=MessageBlock_18
N $8C0F Message: #N($01+(#PC-$8C0F)/$36).
  $8C0F,$36,$0E
L $8C0F,$36,$03

g $8CB1 Table: In-Game Messaging
@ $8CB1 label=Table_InGameMessaging
N $8CB1 Message Block: #N((#PC-$8CB1)/$03).
W $8CB1,$02 Points to #R(#PEEK(#PC)+(#PEEK(#PC+$01)*$100)).
B $8CB3,$01 Number of messages in block: #N(#PEEK(#PC)).
L $8CB1,$03,$13

g $8CEA Messaging?
B $8CEA,$01
W $8CEB,$02
W $8CED,$02
@ $8CEF label=CurrentMessageID
B $8CEF,$01

c $8CF0 Initialise New Game
@ $8CF0 label=InitialiseNewGame
  $8CF0,$06 Write #N$06 to *#R$8F7C and #N$06 to *#R$8F7D.
  $8CF6,$0C Write #N($0000,$04,$04) to; #LIST { *#R$98E3 / *#R$98E4 } { *#R$96B4 / *#R$96B5 } { *#R$96B7 / *#R$96B8 } LIST#
  $8D02,$01 #REGa=#N$00.
  $8D03,$06 Write #N$6464 to *#R$96B5 / *#R$96B6.
  $8D09,$07 Write #N$01 to; #LIST { *#R$8D49 } { *#R$8E42 } LIST#
@ $8D10 label=Game_Loop
  $8D10,$03 Call #R$9822.
@ $8D13 label=InitialiseRound
  $8D13,$04
  $8D17,$03 Call #R$8D4A.
  $8D1A,$03 Jump to #R$8D13 if the response was zero.
  $8D1D,$03 Jump to #R$8D42 if the response was #N$01.
  $8D20,$07 Jump to #R$8D3E if *#R$98E3 is equal to #N$11.
N $8D27 #UDGTABLE { #MESSAGE$12(message-18) } UDGTABLE#
  $8D27,$05 Call #R$7D97 using message block #N$12.
  $8D2C,$05 Write #N$04 to *#R$8F7D.
  $8D31,$03 #REGa=*#R$8D49.
  $8D34,$02,b$01 Flip bit 1.
  $8D36,$06 Write #REGa to; #LIST { *#R$8D49 } { *#R$8E42 } LIST#
  $8D3C,$02 Jump to #R$8D10.

c $8D3E Print "Game Over"
@ $8D3E label=Print_GameOver
N $8D3E #UDGTABLE { #MESSAGE$07(message-07) } UDGTABLE#
  $8D3E,$02 #REGa=#R$8585(#N$07).
  $8D40,$02 Jump to #R$8D44.
N $8D42 #UDGTABLE { #MESSAGE$0E(message-14) } UDGTABLE#
@ $8D42 label=Print_RoundOver
  $8D42,$05 Call #R$7D97 using message block #R$8951(#N$0E).
@ $8D44 label=PrintAlias
  $8D47,$01 #REGa=#N$00.
  $8D48,$01 Return.

g $8D49
B $8D49,$01

c $8D4A Play Game
N $8D4A Reset both the player and girls hands. Note that #N$FF is used to
. signify "draw a new card".
@ $8D4A label=PlayGame
  $8D4A,$03 #REGhl=#R$96C7.
  $8D4D,$02 #REGb=#N$0A (i.e. two hands at #N$05 cards each).
@ $8D4F label=ResetHand_Loop
  $8D4F,$02 Write #N$FF to *#REGhl.
  $8D51,$01 Increment #REGhl by one.
  $8D52,$02 Decrease the card counter by one and loop back to #R$8D4F until both hands have been reset.
N $8D54 Prep the attributes for the final parts of printing the UI.
  $8D54,$05 #HTML(Write #COLOUR$20 to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C8D.html">ATTR_P</a>.)
  $8D59,$05 #HTML(Clear the bottom #N$06 lines using <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0E44.html">CL_LINE</a>.)
  $8D5E,$07 #HTML(Write #N$00 to; #LIST { *#R$96B4 } { *<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C6B.html">DF_SZ</a> } LIST#)
  $8D65,$04 Write #N$01 to *#R$96B8.
  $8D69,$04 Write #N$02 to *#R$8E59.
N $8D6D Print "DROP", "HOLD" and "RAISE".
  $8D6D,$03 #REGhl=#R$9314.
  $8D70,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $8D73,$05 #HTML(Write #N$02 to *<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C6B.html">DF_SZ</a>.)
  $8D78,$03 #REGbc=#N($0720,$04,$04).
  $8D7B,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DD9.html#0DE2">#N$0DE2</a> (CL_SET).)
  $8D7E,$03 Call #R$8E5A.
N $8D81 Print "CURSOR" five times in a row to where it would display under each
. card in the players hand.
  $8D81,$02 #REGb=#N$05.
@ $8D83 label=PrintCursorLoop
  $8D83,$03 #REGhl=#R$930D.
  $8D86,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $8D89,$02 Decrease counter by one and loop back to #R$8D83 until counter is zero.
N $8D8B Blank out #N$07 lines of the display.
  $8D8B,$03 #REGhl=#N$5960 (attribute buffer location).
  $8D8E,$02 #REGb=#N$E0.
@ $8D90 label=Blank_Loop
  $8D90,$02 Write #COLOUR$00 to *#REGhl.
  $8D92,$01 Increment #REGhl by one.
  $8D93,$02 Decrease counter by one and loop back to #R$8D90 until counter is zero.
N $8D95 Make the girl buy in.
  $8D95,$02 #REGa=#N$0A.
  $8D97,$03 Call #R$96A1.
  $8D9A,$04 Write #REGb to *#R$96B7.
  $8D9E,$03 Call #R$9245.
  $8DA1,$04 Write #N$00 to *#R$96B7.
  $8DA5,$03 Call #R$959B.
  $8DA8,$04 #REGix=#R$96CC.
  $8DAC,$03 Call #R$954E.
  $8DAF,$03 Call #R$9518.
  $8DB2,$03 #REGa=*#R$98E4.
  $8DB5,$01 #REGb=#REGa.
  $8DB6,$01 Increment #REGa by one.
  $8DB7,$01 Stash #REGbc on the stack.
  $8DB8,$03 Call #R$96D1.
  $8DBB,$03 Call #R$954E.
  $8DBE,$03 Call #R$9518.
  $8DC1,$01 Restore #REGbc from the stack.
  $8DC2,$02 Decrease counter by one and loop back to #R$8DB7 until counter is zero.
  $8DC4,$03 #REGbc=#N($0007,$04,$04).
  $8DC7,$03 #REGhl=#R$949B.
  $8DCA,$03 #REGde=#R$96C0.
  $8DCD,$02 LDIR.
  $8DCF,$03 Call #R$8F7E.
  $8DD2,$04 #REGix=#R$96C7.
  $8DD6,$03 Call #R$954E.
  $8DD9,$03 Call #R$E313.
  $8DDC,$03 Call #R$9003.
  $8DDF,$03 Call #R$954E.
  $8DE2,$03 Call #R$E313.
  $8DE5,$03 Call #R$9518.
  $8DE8,$03 #REGbc=#N($0007,$04,$04).
  $8DEB,$03 #REGhl=#R$949B.
  $8DEE,$03 #REGde=#R$96B9.
  $8DF1,$02 LDIR.
  $8DF3,$03 Call #R$8F7E.
  $8DF6,$05 Write #N$01 to *#R$8E43.
  $8DFB,$03 #REGa=*#R$8E42.
  $8DFE,$02,b$01 Flip bit 0.
  $8E00,$03 Write #REGa to *#R$8E42.
  $8E03,$02 Jump to #R$8E22 if #REGa is zero.
N $8E05 #UDGTABLE { #MESSAGE$0D(message-13) } UDGTABLE#
  $8E05,$05 Call #R$7D97 using message block #N$0D.
  $8E0A,$03 Call #R$960C.
  $8E0D,$01 Stash #REGaf on the stack.
  $8E0E,$03 Call #R$8F7E.
  $8E11,$01 Restore #REGaf from the stack.
  $8E12,$04 Jump to #R$8F20 if #REGa is zero.
  $8E16,$05 Call #R$8EE2 if #REGa is equal to #N$03.
  $8E1B,$04 Write #N$00 to *#R$8E43.
  $8E1F,$03 Call #R$8E44.
N $8E22 #UDGTABLE { #MESSAGE$0C(message-12) } UDGTABLE#
  $8E22,$05 Call #R$7D97 using message block #N$0C.
  $8E27,$03 Call #R$8F7E.
  $8E2A,$03 Call #R$9171.
  $8E2D,$04 Jump to #R$8F06 if #REGa is zero.
  $8E31,$05 Call #R$8EE2 if #REGa is equal to #N$03.
  $8E36,$04 Write #N$00 to *#R$8E43.
  $8E3A,$03 Call #R$8E44.
  $8E3D,$03 Call #R$8F7E.
  $8E40,$02 Jump to #R$8E05.
B $8E42
B $8E43

c $8E44
  $8E44,$07 Increment *#R$8E59 by one.
  $8E4B,$02 Shift #REGa right.
  $8E4D,$01 Return if {} is lower.
  $8E4E,$03 Write #REGa to *#R$96B8.
  $8E51,$02 Compare #REGa with #N$04...
  $8E53,$01 Restore #REGhl from the stack.
  $8E54,$03 Call #R$8EE2 if #REGa as equal to #N$04 on line #R$8E51.
  $8E57,$01 Stash #REGhl on the stack.
  $8E58,$01 Return.
B $8E59

c $8E5A Draw User Interface
@ $8E5A label=DrawUserInterface
N $8E5A #PUSHS #UDGTABLE
. { #SIM(start=$8D54,stop=$8D6D)#SIM(start=$8D73,stop=$8D81)#SCR$02{$00,$11C,$200,$60}(user-interface) }
. UDGTABLE# #POPS

c $8EE2 Handler: Showdown
@ $8EE2 label=Handler_Showdown
E $8EE2 Continue on to #R$8F06.
  $8EE2,$05 Return if *#R$8E43 is not zero.
  $8EE7,$01 Restore #REGhl from the stack.
N $8EE8 #UDGTABLE { #MESSAGE$09(message-09) } UDGTABLE#
  $8EE8,$05 Call #R$7D97 using message block #N$09.
  $8EED,$04 #REGix=#R$96CC.
  $8EF1,$03 Call #R$E313.
  $8EF4,$03 #REGhl=#R$96B9.
  $8EF7,$03 #REGde=#R$96C0.
  $8EFA,$02 #REGb=#N$07.
@ $8EFC label=CardChecking_Loop
  $8EFC,$04 Jump to #R$8F20 if *#REGde is lower than *#REGhl.
  $8F00,$02 Jump to #R$8F06 if *#REGde is not equal to *#REGhl.
  $8F02,$01 Increment #REGhl by one.
  $8F03,$01 Increment #REGde by one.
  $8F04,$02 Decrease counter by one and loop back to #R$8EFC until counter is zero.

c $8F06 Girl Won Round
@ $8F06 label=GirlWonRound
  $8F06,$0B Update *#R$96B6 as the girl has won this round. So, add *#R$96B4 to
. *#R$96B6 and write the result back to *#R$96B6.
N $8F11 Display a random "I've won" message.
. #UDGTABLE { #MESSAGE$00(message-00) } UDGTABLE#
  $8F11,$04 Call #R$7D97 using message block #N$00.
N $8F15 Check if this is round over or game over for the player.
  $8F15,$0A Call #R$8F3B if *#R$96B5 is lower than #N$0A.
  $8F1F,$01 Return with #REGa being #N$00.

c $8F20 Won Round
@ $8F20 label=WonRound
  $8F20,$0B Update *#R$96B5 as the player has won this round. So, add *#R$96B4
. to *#R$96B5 and write the result back to *#R$96B5.
N $8F2B #UDGTABLE { #MESSAGE$04(message-04) } UDGTABLE#
  $8F2B,$05 Call #R$7D97 using message block #N$04.
N $8F30 Check if this is round over or game over for the girl.
  $8F30,$0A Call #R$8F5A if *#R$96B6 is lower than #N$0A.
  $8F3A,$01 Return with #REGa being #N$00.

c $8F3B Lost Round
@ $8F3B label=LostRound
  $8F3B,$06 Jump to #R$8F52 if *#R$8F7C is zero.
N $8F41 The player lost, so lose a life...
  $8F41,$04 Decrease *#R$8F7C by one.
N $8F45 Replenish the player and girls cash reserves.
  $8F45,$06 Write #N$6464 to #R$96B5.
  $8F4B,$02 #REGa=#N$08 (does nothing, this is immediately overwritten).
  $8F4D,$03 Call #R$779F.
  $8F50,$02 Return with #REGa being #N$00.
N $8F52 #UDGTABLE { #MESSAGE$0E(message-14) } UDGTABLE#
@ $8F52 label=LostRound_GameOver
  $8F52,$05 Call #R$7D97 using message block #R$8951(#N$0E).
  $8F57,$03 Return with #REGa being #N$01.

c $8F5A
  $8F5A,$06 Write #N$6464 to *#R$96B5.
  $8F60,$03 #REGa=*#R$8F7D.
  $8F63,$03 Jump to #R$8F74 if #REGa is zero.
  $8F66,$01 Decrease #REGa by one.
  $8F67,$03 Write #REGa to *#R$8F7D.
  $8F6A,$03 Call #R$9822.
N $8F6D #UDGTABLE { #MESSAGE$05(message-05) } UDGTABLE#
  $8F6D,$05 Call #R$7D97 using message block #N$05.
  $8F72,$01 #REGa=#N$00.
  $8F73,$01 Return.
N $8F74 #UDGTABLE { #MESSAGE$06(message-06) } UDGTABLE#
  $8F74,$05 Call #R$7D97 using message block #N$06.
  $8F79,$02 #REGa=#N$FF.
  $8F7B,$01 Return.

g $8F7C Player Lives
@ $8F7C label=PlayerLives
B $8F7C,$01

g $8F7D Girl Lives
@ $8F7D label=GirlLives
B $8F7D,$01

c $8F7E Print Stats
@ $8F7E label=PrintStats
  $8F7E,$03 #REGhl=#R$8FE2.
  $8F81,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
N $8F84 Print "POT" value.
  $8F84,$03 #REGhl=#R$92C6.
  $8F87,$03 #REGa=*#R$96B4.
  $8F8A,$02 #REGd=#N$00.
  $8F8C,$03 Call #R$8FE9.
N $8F8F Print current round.
  $8F8F,$03 #REGhl=#R$932D.
  $8F92,$03 #REGa=*#R$96B8.
  $8F95,$02 #REGd=#N$FF.
  $8F97,$03 Call #R$8FE9.
N $8F9A Print "YOU" and the players cash reserves.
  $8F9A,$03 #REGhl=#R$92CE.
  $8F9D,$03 #REGa=*#R$96B5.
  $8FA0,$02 #REGd=#N$00.
  $8FA2,$03 Call #R$8FE9.
N $8FA5 Print the girls name and their cash reserve.
  $8FA5,$03 #REGa=*#R$98E4.
  $8FA8,$03 The length of each girls name is #N($000B,$04,$04), so store this in #REGde for the calculation.
  $8FAB,$03 #REGhl=#R$92D6(#N$92CB) (e.g. #R$92D6 less #N($000B,$04,$04)).
@ $8FAE label=FindGirlsName_Loop
  $8FAE,$01 Keep adding #N($000B,$04,$04) to #REGhl while #REGa is non-zero.
  $8FAF,$01 Decrease #REGa by one.
  $8FB0,$02 Jump to #R$8FAE until #REGa is zero.
  $8FB2,$03 #REGa=*#R$96B6.
  $8FB5,$02 #REGd=#N$00.
  $8FB7,$03 Call #R$8FE9.
N $8FBA Print "Raise" and current value.
  $8FBA,$03 #REGhl=#R$92F7.
  $8FBD,$03 #REGa=*#R$96B7.
  $8FC0,$02 #REGd=#N$FE.
  $8FC2,$04 Jump to #R$8FC8 if #REGa is higher than #N$0A.
  $8FC6,$02 #REGd=#N$00.
  $8FC8,$03 Call #R$8FE9.
N $8FCB Prints the players lives.
  $8FCB,$03 #REGhl=#R$9301.
  $8FCE,$03 #REGa=*#R$8F7C.
  $8FD1,$02 #REGd=#N$FF.
  $8FD3,$03 Call #R$8FE9.
  $8FD6,$03 #REGhl=#R$9306.
  $8FD9,$03 #REGa=*#R$8F7D.
  $8FDC,$02 #REGd=#N$FF.
  $8FDE,$03 Call #R$8FE9.
  $8FE1,$01 Return.
B $8FE2,$02 BRIGHT: #MAP(#PEEK(#PC+$01))(OFF,1:ON).
B $8FE4,$02 Set INK: #INK(#PEEK(#PC+$01)).
B $8FE6,$02 Set PAPER: #INK(#PEEK(#PC+$01)).
B $8FE8,$01 "ENTER".
@ $8FE9 label=PrintStatToScreen
  $8FE9,$02 Stash #REGde and #REGaf on the stack.
  $8FEB,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1855.html#187D">OUT_LINE2</a>.)
  $8FEE,$01 Restore #REGaf from the stack.
  $8FEF,$02 #REGb=#N$00.
  $8FF1,$01 #REGc=#REGa.
  $8FF2,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1A1B.html">OUT_NUM_1</a>.)
  $8FF5,$01 Restore #REGde from the stack.
  $8FF6,$01 Increment #REGd by one.
  $8FF7,$01 Return if #REGd is zero.
  $8FF8,$01 Stash #REGde on the stack.
  $8FF9,$03 Print "#CHR$24".
  $8FFC,$01 Restore #REGde from the stack.
  $8FFD,$01 Increment #REGd by one.
  $8FFE,$01 Return if #REGd is zero.
  $8FFF,$03 Print "SPACE".
  $9002,$01 Return.

c $9003 Mark Cards
@ $9003 label=MarkCards
N $9003 #UDGTABLE { #MESSAGE$0F(message-15) } UDGTABLE#
  $9003,$05 Call #R$7D97 using message block #N$0F.
  $9008,$03 #REGhl=#R$9054.
  $900B,$02 #REGb=#N$06.
  $900D,$02 Write #N$00 to *#REGhl.
  $900F,$01 Increment #REGhl by one.
  $9010,$02 Decrease counter by one and loop back to #R$900D until counter is zero.
  $9012,$03 #REGhl=#N$5A1B (attribute buffer location).
  $9015,$03 #REGa=*#R$9054.
  $9018,$03 #REGde=#N($0006,$04,$04).
  $901B,$01 Increment #REGa by one.
  $901C,$01 #REGhl+=#REGde.
  $901D,$01 Decrease #REGa by one.
  $901E,$02 Jump to #R$901C until #REGa is zero.
  $9020,$03 Write #REGhl to *#R$905A.
  $9023,$02 #REGc=#N$00.
  $9025,$01 #REGa=#REGc.
  $9026,$06 Shift #REGa left three positions (with carry).
  $902C,$02,b$01 Set bit 6.
  $902E,$03 #REGhl=*#R$905A.
  $9031,$02 #REGb=#N$06.
  $9033,$01 Write #REGa to *#REGhl.
  $9034,$01 Increment #REGhl by one.
  $9035,$02 Decrease counter by one and loop back to #R$9033 until counter is zero.
  $9037,$02 #REGd=#N$19.
  $9039,$01 Decrease #REGd by one.
  $903A,$02 Jump to #R$9039 until #REGd is zero.
  $903C,$01 Increment #REGc by one.
  $903D,$05 Jump to #R$9025 if #REGc is not equal to #N$08.
  $9042,$03 Call #R$90D8.
  $9045,$01 Set the bits from #REGa.
  $9046,$02 Jump to #R$9093 if #REGa is zero.
  $9048,$04 Jump to #R$905C if #REGa is equal to #N$03.
  $904C,$04 Jump to #R$9068 if #REGa is equal to #N$04.
  $9050,$02 Jump to #R$90BB if #REGa is lower than #N$04.
  $9052,$02 Jump to #R$9023.

b $9054
  $9054,$01
  $9055
W $905A,$02

c $905C
  $905C,$03 #REGa=*#R$9054.
  $905F,$01 Stash #REGaf on the stack.
  $9060,$01 Set the bits from #REGa.
  $9061,$02 Jump to #R$9065 if #REGa is not zero.
  $9063,$02 #REGa=#N$05.
  $9065,$01 Decrease #REGa by one.
  $9066,$02 Jump to #R$9073.
  $9068,$03 #REGa=*#R$9054.
  $906B,$01 Stash #REGaf on the stack.
  $906C,$04 Jump to #R$9072 if #REGa is not equal to #N$04.
  $9070,$02 #REGa=#N$FF.
  $9072,$01 Increment #REGa by one.
  $9073,$03 Write #REGa to *#R$9054.
  $9076,$01 Restore #REGaf from the stack.
  $9077,$01 Increment #REGa by one.
  $9078,$01 #REGb=#REGa.
  $9079,$03 #REGhl=#R$9054.
  $907C,$01 Increment #REGhl by one.
  $907D,$01 Decrease #REGa by one.
  $907E,$02 Jump to #R$907C until #REGa is zero.
  $9080,$01 #REGa=*#REGhl.
  $9081,$03 #REGhl=#N$5A1B (attribute buffer location).
  $9084,$03 #REGde=#N($0006,$04,$04).
  $9087,$01 #REGhl+=#REGde.
  $9088,$02 Decrease counter by one and loop back to #R$9087 until counter is zero.
  $908A,$02 #REGb=#N$06.
  $908C,$01 Write #REGa to *#REGhl.
  $908D,$01 Increment #REGhl by one.
  $908E,$02 Decrease counter by one and loop back to #R$908C until counter is zero.
  $9090,$03 Jump to #R$9012.
  $9093,$03 #REGhl=#R$9055.
  $9096,$02 #REGb=#N$05.
  $9098,$02 #REGc=#N$00.
  $909A,$01 #REGa=*#REGhl.
  $909B,$01 Set the bits from #REGa.
  $909C,$02 Jump to #R$909F if #REGa is zero.
  $909E,$01 Increment #REGc by one.
  $909F,$01 Increment #REGhl by one.
  $90A0,$02 Decrease counter by one and loop back to #R$909A until counter is zero.
  $90A2,$03 #REGa=*#R$9054.
  $90A5,$01 Increment #REGa by one.
  $90A6,$03 #REGhl=#R$9054.
  $90A9,$01 Increment #REGhl by one.
  $90AA,$01 Decrease #REGa by one.
  $90AB,$02 Jump to #R$90A9 until #REGa is zero.
  $90AD,$05 Jump to #R$90B5 if #REGc is lower than #N$03.
  $90B2,$01 #REGa=#N$00.
  $90B3,$02 Jump to #R$90B8.
  $90B5,$01 #REGa=*#REGhl.
  $90B6,$02,b$01 Flip bits 0-5.
  $90B8,$01 Write #REGa to *#REGhl.
  $90B9,$02 Jump to #R$9090.
  $90BB,$03 #REGde=#R$9055.
  $90BE,$03 #REGhl=#R$96C7.
  $90C1,$02 #REGb=#N$05.
  $90C3,$01 #REGa=*#REGde.
  $90C4,$01 Set the bits from #REGa.
  $90C5,$02 Jump to #R$90C9 if #REGa is zero.
  $90C7,$02 Write #N$FF to *#REGhl.
  $90C9,$01 Increment #REGhl by one.
  $90CA,$01 Increment #REGde by one.
  $90CB,$02 Decrease counter by one and loop back to #R$90C3 until counter is zero.
  $90CD,$03 #REGhl=#N$5A21 (attribute buffer location).
  $90D0,$02 #REGb=#N$1E.
  $90D2,$02 Write #N$00 to *#REGhl.
  $90D4,$01 Increment #REGhl by one.
  $90D5,$02 Decrease counter by one and loop back to #R$90D2 until counter is zero.
  $90D7,$01 Return.

c $90D8 Controls: Get Input
@ $90D8 label=Controls
  $90D8,$04 #HTML(Write #N$00 to *<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $90DC,$07 Jump to #R$90EC if *#R$913E is not equal to #N$06.
  $90E3,$03 Call #R$9148.
  $90E6,$01 #REGa=Player input.
  $90E7,$03 Jump to #R$9103 if no input was detected (#N$FF for "no input was made").
  $90EA,$02 Jump to #R$9108.
@ $90EC label=Controls_ReadKeyboard
  $90EC,$03 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/02BF.html">KEYBOARD</a>.)
  $90EF,$03 #REGhl=#R$913E.
  $90F2,$03 #HTML(#REGa=*<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $90F5,$05 Jump to #R$9722 if #REGa is equal to #N$0E.
N $90FA Detect the keyboard input.
  $90FA,$02 Set a counter of #N$05 for the number of controls to be read.
@ $90FC label=Controls_ReadKeyboard_Loop
  $90FC,$03 Jump to #R$9106 if the currently pressed key is equal to *#REGhl.
  $90FF,$02 Increment #REGhl by two.
  $9101,$02 Decrease counter by one and loop back to #R$90FC until counter is zero.
N $9103 No input was detected so return with #N$FF.
@ $9103 label=Controls_NoInput
  $9103,$02 #REGa=#N$FF.
  $9105,$01 Return.
N $9106 A valid key press was detected, handle it.
@ $9106 label=Controls_HandleKeyPress
  $9106,$01 Increment #REGhl by one.
  $9107,$01 #REGa=*#REGhl.
  $9108,$01 Stash #REGaf on the stack.
  $9109,$06 Jump to #R$9124 if *#R$92C5 is not zero.
  $910F,$07 Jump to #R$911E if *#R$913E is not equal to #N$06.
  $9116,$03 Call #R$9148.
  $9119,$01 Increment #REGc by one.
  $911A,$02 Jump to #R$9116 if #REGc is not zero.
  $911C,$02 Jump to #R$9124.
N $911E Debounce the key press.
@ $911E label=DebounceLoop
  $911E,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
N $9121 Handle if no keys are being pressed, for reference:
N $9121 #HTML(<blockquote>In all instances the #REGe register is returned with
. a value in the range of +#N$00 to +#N$27, the value being different for each
. of the forty keys of the keyboard, or the value +#N$FF, for no-key.</blockquote>)
  $9121,$01 Set the zero flag if no keys have been pressed.
  $9122,$02 Jump to #R$911E unless no keys are being pressed.
N $9124 Play the "select" key wave sound.
@ $9124 label=PlaySelectWaveSound
  $9124,$04 Write #N$00 to *#R$92C5.
  $9128,$01 Restore #REGaf from the stack.
  $9129,$02 Return if #REGa is not zero.
  $912B,$01 Disable interrupts.
  $912C,$02 #REGb=#N$C9.
  $912E,$02 #REGa=#N$FC.
@ $9130 label=SelectSoundLoop
  $9130,$02 #REGc=#N$32.
@ $9132 label=SelectSoundDurationLoop
  $9132,$01 Decrease #REGc by one.
  $9133,$02 Jump to #R$9132 until #REGc is zero.
  $9137,$02,b$01 Flip bit 4.
M $9135,$04 Flip the speaker bit (bit 4), and send the result to the speaker.
  $9139,$02 Decrease counter by one and loop back to #R$9130 until counter is zero.
  $913B,$01 #REGa=#N$00.
  $913C,$01 Enable interrupts.
  $913D,$01 Return.

g $913E User-Defined Keys
@ $913E label=UserDefinedKeys
D $913E Used by the routine at #R$6F50.
B $913E,$02
L $913E,$02,$05

c $9148 Read Kempston Joystick
@ $9148 label=Controls_ReadKempston
R $9148 O:C Key press input
N $9148 The response will be:
. #TABLE(default,centre,centre)
. { =h Byte | =h Meaning }
. { #N$00 | Select (fire) }
. { #N$01 | Up }
. { #N$02 | Down }
. { #N$03 | Left }
. { #N$04 | Right }
. { #N$FF | No input }
. TABLE#
  $9148,$02 Set a read counter of #N$3A.
@ $914A label=Controls_ReadKempston_Loop
  $914A,$02 Read Kempston Joystick input.
  $914C,$02 Decrease the read counter by one and loop back to #R$9148 until the counter is zero.
  $914E,$05 Return with #REGc being #N$00 if "fire" has been pressed.
  $9153,$04 Return with #REGc being #N$01 if "up" has been pressed.
  $9157,$04 Return with #REGc being #N$02 if "down" has been pressed.
  $915B,$04 Return with #REGc being #N$03 if "left" has been pressed.
  $915F,$04 Return with #REGc being #N$04 if "right" has been pressed.
  $9163,$03 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/02BF.html">KEYBOARD</a>.)
  $9166,$08 #HTML(Jump to #R$9722 if <a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed) is #N$0E.)
  $916E,$02 #REGc=#N$FF.
  $9170,$01 Return.

c $9171
  $9171,$05 Write #N$01 to *#R$91D8.
  $9176,$02 #REGb=#COLOUR$68.
  $9178,$03 Call #R$91C2.
  $917B,$03 Call #R$90D8.
  $917E,$04 Jump to #R$918B if "left" has been pressed.
  $9182,$04 Jump to #R$918B if "right" has been pressed.
  $9186,$03 Jump to #R$91B2 if "select" has been pressed.
  $9189,$02 Jump to #R$917B.
  $918B,$01 Stash #REGaf on the stack.
  $918C,$02 #REGb=#COLOUR$78.
  $918E,$03 Call #R$91C2.
  $9191,$01 Restore #REGaf from the stack.
  $9192,$02 Compare #REGa with #N$04.
  $9194,$03 #REGa=*#R$91D8.
  $9197,$02 Jump to #R$91A1 if #REGa was equal to #N$04 on line #R$9192.
  $9199,$03 Jump to #R$919E if *#R$91D8 is not zero.
  $919C,$02 #REGa=#N$03.
  $919E,$01 Decrease #REGa by one.
  $919F,$02 Jump to #R$91A8.
  $91A1,$04 Jump to #R$91A7 if #REGa is not equal to #N$02.
  $91A5,$02 #REGa=#N$FF.
  $91A7,$01 Increment #REGa by one.
  $91A8,$03 Write #REGa to *#R$91D8.
  $91AB,$02 #REGb=#COLOUR$68.
  $91AD,$03 Call #R$91C2.
  $91B0,$02 Jump to #R$917B.
  $91B2,$02 #REGb=#COLOUR$78.
  $91B4,$03 Call #R$91C2.
  $91B7,$06 Jump to #R$91D9 if *#R$91D8 is zero.
  $91BD,$01 Decrease #REGa by one.
  $91BE,$02 Jump to #R$922D if #REGa is zero.
  $91C0,$02 Jump to #R$91E0.
  $91C2,$03 #REGa=*#R$91D8.
  $91C5,$03 #REGhl=#N$5AB7 (attribute buffer location).
  $91C8,$03 #REGde=#N($000A,$04,$04).
  $91CB,$01 Increment #REGa by one.
  $91CC,$01 #REGhl+=#REGde.
  $91CD,$01 Decrease #REGa by one.
  $91CE,$02 Jump to #R$91CC until #REGa is zero.
  $91D0,$01 #REGa=#REGb.
  $91D1,$02 #REGb=#N$0A.
  $91D3,$01 Write #REGa to *#REGhl.
  $91D4,$01 Increment #REGhl by one.
  $91D5,$02 Decrease counter by one and loop back to #R$91D3 until counter is zero.
  $91D7,$01 Return.
B $91D8,$01
N $91D9 #UDGTABLE { #MESSAGE$0A(message-10) } UDGTABLE#
  $91D9,$05 Call #R$7D97 using message block #R$8735(#N$0A).
  $91DE,$01 #REGa=#N$00.
  $91DF,$01 Return.
  $91E0,$08 Jump to #R$9171 if *#R$8E59 is equal to #N$07.
  $91E8,$03 #REGa=*#R$96B5.
  $91EB,$01 #REGc=#REGa.
  $91EC,$04 Jump to #R$9171 if *#R$96B5 is zero.
  $91F0,$03 #REGa=*#R$96B6.
  $91F3,$04 Jump to #R$9171 if *#R$96B6 is zero.
  $91F7,$03 #REGa=*#R$96B7.
  $91FA,$01 #REGa-=#REGc.
  $91FB,$03 Jump to #R$9171 if {} is zero.
  $91FE,$01 #REGa+=#REGc.
  $91FF,$01 Stash #REGaf on the stack.
  $9200,$05 Write #N$01 to *#R$96B7.
  $9205,$03 Call #R$8F7E.
  $9208,$01 Restore #REGaf from the stack.
  $9209,$03 Write #REGa to *#R$96B7.
  $920C,$03 Call #R$9245.
  $920F,$05 Write #N$01 to *#R$96B7.
  $9214,$03 Call #R$9258.
  $9217,$03 #REGa=*#R$96B5.
  $921A,$01 #REGa-=#REGb.
  $921B,$03 Write #REGa to *#R$96B5.
  $921E,$03 #REGa=*#R$96B4.
  $9221,$01 #REGa+=#REGb.
  $9222,$03 Write #REGa to *#R$96B4.
N $9225 #UDGTABLE { #MESSAGE$10(message-16) } UDGTABLE#
  $9225,$05 Call #R$7D97 using message block #R$8A29(#N$10).
  $922A,$02 #REGa=#N$01.
  $922C,$01 Return.
  $922D,$06 Jump to #R$9242 if *#R$96B7 is zero.
  $9233,$03 Call #R$9245.
  $9236,$04 Write #N$00 to *#R$96B7.
N $923A #UDGTABLE { #MESSAGE$0B(message-11) } UDGTABLE#
  $923A,$05 Call #R$7D97 using message block #R$8843(#N$0B).
  $923F,$02 #REGa=#N$02.
  $9241,$01 Return.
  $9242,$02 #REGa=#N$03.
  $9244,$01 Return.

c $9245 Player Add To Pot
@ $9245 label=PlayerAddToPot
  $9245,$0B Subtract *#R$96B7 from *#R$96B5 and write it back to *#R$96B5.
  $9250,$07 Add *#R$96B7 to *#R$96B4 and write this back to *#R$96B4.
  $9257,$01 Return.

c $9258
  $9258,$02 #REGa=#COLOUR$68.
  $925A,$03 #REGhl=#N$5A95 (attribute buffer location).
  $925D,$03 Call #R$91D1.
N $9260 #UDGTABLE { #MESSAGE$11(message-17) } UDGTABLE#
  $9260,$05 Call #R$7D97 using message block #R$8B6D(#N$11).
  $9265,$05 Write #N$01 to *#R$92C5.
  $926A,$02 Restore #REGix from the stack.
  $926C,$03 Call #R$90D8.
  $926F,$02 Stash #REGix on the stack.
  $9271,$01 Set the bits from #REGa.
  $9272,$02 Jump to #R$927C if #REGa is zero.
  $9274,$01 Decrease #REGa by one.
  $9275,$02 Jump to #R$92A7 if #REGa is zero.
  $9277,$01 Decrease #REGa by one.
  $9278,$02 Jump to #R$9289 if #REGa is zero.
  $927A,$02 Jump to #R$9265.
  $927C,$02 #REGa=#COLOUR$78.
  $927E,$03 #REGhl=#N$5A95 (attribute buffer location).
  $9281,$03 Call #R$91D1.
  $9284,$04 #REGb=*#R$96B7.
  $9288,$01 Return.

  $9289,$03 #REGa=*#R$96B7.
  $928C,$01 Increment #REGa by one.
  $928D,$04 Jump to #R$9265 if #REGa is higher than #N$15.
  $9291,$01 #REGb=#REGa.
  $9292,$06 Jump to #R$9265 if *#R$96B5 is lower than #REGb.
  $9298,$06 Jump to #R$9265 if *#R$96B6 is lower than #REGb.
  $929E,$01 #REGa=#REGb.
  $929F,$03 Write #REGa to *#R$96B7.
  $92A2,$03 Call #R$8F7E.
  $92A5,$02 Jump to #R$92B3.

  $92A7,$03 #REGa=*#R$96B7.
  $92AA,$01 Decrease #REGa by one.
  $92AB,$02 Jump to #R$9265 if #REGa is zero.
  $92AD,$03 Write #REGa to *#R$96B7.
  $92B0,$03 Call #R$8F7E.
  $92B3,$02 #REGa=#COLOUR$68.
  $92B5,$03 #REGhl=#N$5A95 (attribute buffer location).
  $92B8,$03 Call #R$91D1.
  $92BB,$03 #REGbc=#N$4000 (screen buffer location).
  $92BE,$01 Decrease #REGc by one.
  $92BF,$02 Jump to #R$92BE until #REGc is zero.
  $92C1,$02 Decrease counter by one and loop back to #R$92BE until counter is zero.
  $92C3,$02 Jump to #R$9265.
B $92C5,$01

t $92C6 Messaging: In-Game
@ $92C6 label=Messaging_InGame
B $92C6,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92C9,$04 "#STR(#PC,$04,$04)".
B $92CD,$01
@ $92CE label=Messaging_You
B $92CE,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92D1,$04 "#STR(#PC,$04,$04)".
B $92D5,$01
@ $92D6 label=Messaging_Sheila
B $92D6,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92D9,$07 "#STR(#PC,$04,$07)".
B $92E0,$01
@ $92E1 label=Messaging_Ireen
B $92E1,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92E4,$07 "#STR(#PC,$04,$07)".
B $92EB,$01
@ $92EC label=Messaging_Diane
B $92EC,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92EF,$07 "#STR(#PC,$04,$07)".
B $92F6,$01
@ $92F7 label=Messaging_Raise
B $92F7,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $92FA,$06 "#STR(#PC,$04,$06)".
B $9300,$01
@ $9301 label=Messaging_PlayerLivesHash
B $9301,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $9304,$01 "#STR(#PC,$04,$01)".
B $9305,$01
@ $9306 label=Messaging_GirlLivesHash
B $9306,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
B $9309,$01
B $930A,$01
  $930B,$01 "#STR(#PC,$04,$01)".
B $930C,$01
@ $930D label=Messaging_Cursor
  $930D,$06 "#STR(#PC,$04,$06)".
B $9313,$01
@ $9314 label=Messaging_Drop
B $9314,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $9317,$04 "#STR(#PC,$04,$04)".
B $931B,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $931E,$06 "#STR(#PC,$04,$06)".
B $9324,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $9327,$05 "#STR(#PC,$04,$05)".
B $932C,$01
@ $932D label=Messaging_Round
B $932D,$03 PRINT AT: #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $9330,$06 "#STR(#PC,$04,$06)".
B $9336,$01

c $9337
  $9337,$03 #REGhl=#R$949B.
  $933A,$02 #REGb=#N$07.
  $933C,$02 Write #N$00 to *#REGhl.
  $933E,$01 Increment #REGhl by one.
  $933F,$02 Decrease counter by one and loop back to #R$933C until counter is zero.
  $9341,$03 Call #R$94A2.
  $9344,$02 Jump to #R$9359 if {} is not zero.
  $9346,$01 Decrease #REGhl by one.
  $9347,$03 Call #R$9473.
  $934A,$03 Write #REGa to *#R$949C.
  $934D,$03 Call #R$947B.
  $9350,$03 Write #REGa to *#R$949D.
  $9353,$05 Write #N$09 to *#R$949B.
  $9358,$01 Return.
  $9359,$03 Call #R$94AA.
  $935C,$02 Jump to #R$936E if {} is not zero.
  $935E,$03 Call #R$9473.
  $9361,$03 Write #REGa to *#R$949C.
  $9364,$05 Write #N$08 to *#R$949B.
  $9369,$04 Write #N$00 to *#R$949D.
  $936D,$01 Return.
  $936E,$03 Call #R$94B8.
  $9371,$02 Jump to #R$9386 if {} is not zero.
  $9373,$03 #REGhl=*#R$9516.
  $9376,$03 Call #R$9473.
  $9379,$03 Write #REGa to *#R$949C.
  $937C,$05 Write #N$07 to *#R$949B.
  $9381,$04 Write #N$00 to *#R$949D.
  $9385,$01 Return.
  $9386,$03 Call #R$94C1.
  $9389,$02 Jump to #R$93B0 if {} is not zero.
  $938B,$03 #REGa=*#REGix+#N$00.
  $938E,$02 #REGb=#N$04.
  $9390,$02 Shift #REGa right (with carry).
  $9392,$02 Decrease counter by one and loop back to #R$9390 until counter is zero.
  $9394,$03 Write #REGa to *#R$949D.
  $9397,$05 Write #N$06 to *#R$949B.
  $939C,$02 #REGd=#N$00.
  $939E,$02 Stash #REGix on the stack.
  $93A0,$01 Restore #REGhl from the stack.
  $93A1,$02 #REGb=#N$05.
  $93A3,$01 #REGa=*#REGhl.
  $93A4,$02,b$01 Keep only bits 0-3.
  $93A6,$03 Jump to #R$93AA if #REGa is higher than #REGd.
  $93A9,$01 #REGd=#REGa.
  $93AA,$02 Decrease counter by one and loop back to #R$93A3 until counter is zero.
  $93AC,$03 Write #REGa to *#R$949C.
  $93AF,$01 Return.

  $93B0,$03 Call #R$94C7.
  $93B3,$02 Jump to #R$93C9 if {} is not zero.
  $93B5,$01 Decrease #REGhl by one.
  $93B6,$01 #REGa=*#REGhl.
  $93B7,$03 Call #R$9473.
  $93BA,$03 Write #REGa to *#R$949C.
  $93BD,$03 Call #R$947B.
  $93C0,$03 Write #REGa to *#R$949D.
  $93C3,$05 Write #N$05 to *#R$949B.
  $93C8,$01 Return.
  $93C9,$03 Call #R$94DA.
  $93CC,$02 Jump to #R$93DE if {} is not zero.
  $93CE,$03 Call #R$9473.
  $93D1,$03 Write #REGa to *#R$949C.
  $93D4,$05 Write =#N$04 to *#R$949B.
  $93D9,$04 Write #N$00 to *#R$949D.
  $93DD,$01 Return.
  $93DE,$03 Call #R$94E8.
  $93E1,$02 Jump to #R$9412 if {} is not zero.
  $93E3,$03 Call #R$9473.
  $93E6,$03 Write #REGa to *#R$949C.
  $93E9,$03 #REGhl=*#R$9516.
  $93EC,$03 Call #R$9473.
  $93EF,$03 Write #REGa to *#R$949E.
  $93F2,$03 #REGhl=#R$9540.
  $93F5,$05 Jump to #R$93FD if *#REGhl is equal to #N$01.
  $93FA,$01 Increment #REGhl by one.
  $93FB,$02 Jump to #R$93F5.
  $93FD,$03 Call #R$9473.
  $9400,$03 Write #REGa to *#R$949F.
  $9403,$03 #REGa=*#R$949C.
  $9406,$03 Call #R$947B.
  $9409,$03 Write #REGa to *#R$949D.
  $940C,$05 Write #N$03 to *#R$949B.
  $9411,$01 Return.

  $9412,$03 Call #R$9506.
  $9415,$02 Jump to #R$9447 if {} is not zero.
  $9417,$03 Call #R$9473.
  $941A,$03 Write #REGa to *#R$949C.
  $941D,$05 Write #N$02 to *#R$949B.
  $9422,$02 #REGb=#N$0D.
  $9424,$03 #REGde=#R$949E.
  $9427,$03 #REGhl=#R$954C.
  $942A,$05 Jump to #R$943C if *#REGhl is equal to #N$01.
  $942F,$01 Decrease #REGhl by one.
  $9430,$02 Decrease counter by one and loop back to #R$942A until counter is zero.
  $9432,$03 #REGa=*#R$949C.
  $9435,$03 Call #R$947B.
  $9438,$03 Write #REGa to *#R$949D.
  $943B,$01 Return.

  $943C,$02 Stash #REGhl and #REGde on the stack.
  $943E,$03 Call #R$9473.
  $9441,$02 Restore #REGde and #REGhl from the stack.
  $9443,$01 Write #REGa to *#REGde.
  $9444,$01 Increment #REGde by one.
  $9445,$02 Jump to #R$942F.
  $9447,$03 Call #R$950D.
  $944A,$01 Stash #REGhl on the stack.
  $944B,$03 Call #R$9473.
  $944E,$01 Increment #REGa by one.
  $944F,$03 Write #REGa to *#R$949C.
  $9452,$03 Call #R$947B.
  $9455,$03 Write #REGa to *#R$949D.
  $9458,$01 Restore #REGhl from the stack.
  $9459,$02 #REGa=#N$01.
  $945B,$03 Write #REGa to *#R$949B.
  $945E,$02 #REGb=#N$04.
  $9460,$03 #REGde=#R$949E.
  $9463,$03 Call #R$9510.
  $9466,$02 Stash #REGhl and #REGde on the stack.
  $9468,$03 Call #R$9473.
  $946B,$02 Restore #REGde and #REGhl from the stack.
  $946D,$01 Increment #REGa by one.
  $946E,$01 Write #REGa to *#REGde.
  $946F,$01 Increment #REGde by one.
  $9470,$02 Decrease counter by one and loop back to #R$9463 until counter is zero.
  $9472,$01 Return.

c $9473
  $9473,$03 #REGde=#R$9540.
  $9476,$01 #REGa=#N$00.
  $9477,$02 #REGhl-=#REGde (with carry).
  $9479,$01 #REGa=#REGl.
  $947A,$01 Return.

c $947B
  $947B,$01 #REGd=#REGa.
  $947C,$02 #REGe=#N$00.
  $947E,$02 Stash #REGix on the stack.
  $9480,$01 Restore #REGhl from the stack.
  $9481,$02 #REGb=#N$05.
  $9483,$01 #REGa=*#REGhl.
  $9484,$02,b$01 Keep only bits 0-3.
  $9486,$03 Jump to #R$9494 if #REGa is equal to #REGd.
  $9489,$01 Increment #REGhl by one.
  $948A,$02 Decrease counter by one and loop back to #R$9483 until counter is zero.
  $948C,$01 #REGa=#REGe.
  $948D,$02 #REGb=#N$04.
  $948F,$02 Shift #REGa right (with carry).
  $9491,$02 Decrease counter by one and loop back to #R$948F until counter is zero.
  $9493,$01 Return.

  $9494,$04 Jump to #R$9489 if *#REGhl is lower than #REGe.
  $9498,$01 #REGe=#REGa.
  $9499,$02 Jump to #R$9489.

b $949B
  $949B,$01
  $949C,$01
  $949E,$01

c $94A2
  $94A2,$06 Return if *#R$954D is not equal to #N$01.
  $94A8,$02 Jump to #R$94C7.

  $94AA,$03 #REGhl=#R$9540.
  $94AD,$02 #REGb=#N$0D.
  $94AF,$04 Return if  *#REGhl is equal to #N$04.
  $94B3,$01 Increment #REGhl by one.
  $94B4,$02 Decrease counter by one and loop back to #R$94AF until counter is zero.
  $94B6,$01 Increment #REGb by one.
  $94B7,$01 Return.

  $94B8,$03 Call #R$94DA.
  $94BB,$03 Write #REGhl to *#R$9516.
  $94BE,$01 Return if #REGa is not zero.
  $94BF,$02 Jump to #R$9506.
  $94C1,$05 Compare *#R$954D with #N$01.
  $94C6,$01 Return.

  $94C7,$03 #REGhl=#R$9540(#N$953F).
  $94CA,$01 Increment #REGhl by one.
  $94CB,$05 Jump to #R$94CA if *#REGhl is not equal to #N$01.
  $94D0,$02 #REGb=#N$05.
  $94D2,$04 Return if *#REGhl is not equal to #N$01.
  $94D6,$01 Increment #REGhl by one.
  $94D7,$02 Decrease counter by one and loop back to #R$94D2 until counter is zero.
  $94D9,$01 Return.

  $94DA,$03 #REGhl=#R$9540.
  $94DD,$02 #REGb=#N$0D.
  $94DF,$04 Return if *#REGhl is equal to #N$03.
  $94E3,$01 Increment #REGhl by one.
  $94E4,$02 Decrease counter by one and loop back to #R$94DF until counter is zero.
  $94E6,$01 Increment #REGb by one.
  $94E7,$01 Return.

  $94E8,$03 #REGhl=#R$9540.
  $94EB,$02 #REGb=#N$0D.
  $94ED,$05 Jump to #R$94F7 if *#REGhl is equal to #N$02.
  $94F2,$01 Increment #REGhl by one.
  $94F3,$02 Decrease counter by one and loop back to #R$94ED until counter is zero.
  $94F5,$01 Increment #REGb by one.
  $94F6,$01 Return.
  $94F7,$01 Decrease #REGb by one.
  $94F8,$03 Write #REGhl to *#R$9516.
  $94FB,$02 Jump to #R$94F5 if #REGb is zero.
  $94FD,$01 Increment #REGhl by one.
  $94FE,$04 Return if *#REGhl is equal to #N$02.
  $9502,$02 Decrease counter by one and loop back to #R$94FD until counter is zero.
  $9504,$02 Jump to #R$94F5.
  $9506,$02 #REGb=#N$0D.
  $9508,$03 #REGhl=#R$9540(#N$953F).
  $950B,$02 Jump to #R$94FD.

  $950D,$03 #REGhl=#R$954C.
  $9510,$01 #REGa=*#REGhl.
  $9511,$01 Decrease #REGhl by one.
  $9512,$03 Jump to #R$9510 if #REGa is zero.
  $9515,$01 Return.

g $9516
W $9516,$02

c $9518
  $9518,$03 #REGhl=#R$9540.
  $951B,$02 #REGb=#N$0D.
  $951D,$02 Write #N$00 to *#REGhl.
  $951F,$01 Increment #REGhl by one.
  $9520,$02 Decrease counter by one and loop back to #R$951D until counter is zero.
  $9522,$02 Stash #REGix on the stack.
  $9524,$03 #REGhl=#REGix (using the stack).
  $9527,$02 #REGb=#N$05.
  $9529,$04 #REGix=#R$9540.
  $952D,$01 #REGa=*#REGhl.
  $952E,$02,b$01 Keep only bits 0-3.
  $9530,$01 #REGe=#REGa.
  $9531,$02 #REGd=#N$00.
  $9533,$02 #REGix+=#REGde.
  $9535,$03 Increment *#REGix+#N$00 by one.
  $9538,$01 Increment #REGhl by one.
  $9539,$02 Decrease counter by one and loop back to #R$9529 until counter is zero.
  $953B,$02 Restore #REGix from the stack.
  $953D,$03 Jump to #R$95EF.

b $9540
  $954C
  $954D

c $954E Draw Cards
@ $954E label=DrawCards
R $954E IX Pointer to either the player or girls hand
N $954E If a card value in the players hand is #N$FF this indicates that a card needs to be drawn.
N $954E If a card value in #R$95BB is #N$FF this indicates that the card has already been chosen.
  $954E,$02 Stash #REGix on the stack.
  $9550,$03 #REGde=#REGix (using the stack).
  $9553,$02 A hand consists of #N$05 cards.
@ $9555 label=DrawCards_Loop
  $9555,$01 Stash the card count on the stack.
@ $9556 label=DrawCards_RePick
  $9556,$03 #REGhl=#R$95BB.
N $9559 Only draw a card if the current position in the hand is marked as needing to be picked.
  $9559,$05 Jump to #R$9572 if the hand pointer is not equal to #N$FF.
  $955E,$02 Stash the hand and deck pointers on the stack temporarily.
  $9560,$03 Call #R$9579.
  $9563,$02 Restore the deck and hand pointers from the stack.
  $9565,$03 Create an offset in #REGbc.
  $9568,$01 Decrease the card count by one.
  $9569,$01 #REGhl+=#REGbc.
  $956A,$05 Jump to #R$9556 if this card has already been picked (if the chosen card "value" is equal to #N$FF).
N $956F The picked card is valid and able to be drawn into the hand.
  $956F,$01 Write the drawn card to the current hand position.
  $9570,$02 Now mark the card in the deck as being unavailable so it can't be chosen again.
@ $9572 label=DrawCards_Next
  $9572,$01 Restore the card count from the stack.
  $9573,$01 Increment the hand pointer by one.
  $9574,$02 Decrease the card count by one and loop back to #R$9555 until the deck is filled.
  $9576,$02 Restore #REGix from the stack.
  $9578,$01 Return.

c $9579 Get Random Number
@ $9579 label=GetRandomNumber
  $9579,$03 #REGh=#REGr.
  $957F,$03 #REGl=#REGr.
  $9582,$05 #HTML(#REGhl+=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES+#N$01</a>.)
  $959A,$01 Return.

c $959B Reset Deck
@ $959B label=ResetDeck
  $959B,$03 #REGhl=#R$95BB.
  $959E,$02 #REGc=#N$00.
  $95A0,$02 #REGb=#N$00.
  $95A2,$01 #REGa=#REGc.
  $95A3,$01 Stash #REGbc on the stack.
  $95A4,$02 #REGb=#N$04.
  $95A6,$02 Shift #REGa left (with carry).
  $95A8,$02 Decrease counter by one and loop back to #R$95A6 until counter is zero.
  $95AA,$01 Restore #REGbc from the stack.
  $95AB,$01 Set the bits from #REGb.
  $95AC,$01 Write #REGa to *#REGhl.
  $95AD,$01 Increment #REGhl by one.
  $95AE,$01 Increment #REGb by one.
N $95AF There are #N$0D cards for each suit.
  $95AF,$05 Jump to #R$95A2 if #REGb is not equal to #N$0D.
  $95B4,$01 Increment #REGc by one.
N $95B5 There are four suits.
  $95B5,$05 Jump to #R$95A0 if #REGc is not equal to #N$04.
  $95BA,$01 Return.

g $95BB Card Deck
@ $95BB label=CardDeck
B $95BB,$34,$0D

c $95EF
  $95EF,$02 Stash #REGix on the stack.
  $95F1,$01 Restore #REGde from the stack.
  $95F2,$02 #REGb=#N$04.
  $95F4,$01 #REGa=*#REGde.
  $95F5,$02,b$01 Keep only bits 4-7.
  $95F7,$01 #REGh=#REGa.
  $95F8,$01 Increment #REGde by one.
  $95F9,$01 #REGa=*#REGde.
  $95FA,$02,b$01 Keep only bits 4-7.
  $95FC,$03 Jump to #R$9609 if #REGa is not equal to #REGh.
  $95FF,$02 Decrease counter by one and loop back to #R$95F8 until counter is zero.
  $9601,$02 #REGa=#N$01.
  $9603,$03 Write #REGa to *#R$954D.
  $9606,$03 Jump to #R$9337.
  $9609,$01 #REGa=#N$00.
  $960A,$02 Jump to #R$9603.

c $960C
  $960C,$03 #REGa=*#R$96C0.
  $960F,$01 #REGc=#REGa.
  $9610,$04 Jump to #R$9626 if #REGa is lower than #N$02.
  $9614,$02 Rotate #REGc left.
  $9616,$04 Jump to #R$961C if #REGa is lower than #N$04.
  $961A,$02 Rotate #REGc left.
  $961C,$01 #REGb=#REGc.
  $961D,$03 Call #R$9579.
  $9620,$04 Jump to #R$9637 if #REGa is lower than #N$0E.
  $9624,$02 Decrease counter by one and loop back to #R$961D until counter is zero.
  $9626,$01 #REGb=#REGc.
  $9627,$03 Call #R$9579.
  $962A,$04 Jump to #R$968C if #REGa is lower than #N$1E.
  $962E,$02 Decrease counter by one and loop back to #R$9627 until counter is zero.
N $9630 #UDGTABLE { #MESSAGE$01(message-01) } UDGTABLE#
  $9630,$05 Call #R$7D97 using message block #N$01.
  $9635,$01 #REGa=#N$00
  $9636,$01 Return.
  $9637,$07 Jump to #R$968C if *#R$8E59 is equal to #N$07.
  $963E,$03 #REGa=*#R$96B7.
  $9641,$03 Call #R$96A1.
  $9644,$03 Call #R$9579.
  $9647,$02 Shift #REGa right (with carry).
  $9649,$02 #REGa-=#N$06.
  $964B,$02 Jump to #R$9644 if {} is lower.
  $964D,$01 #REGb=#REGa.
  $964E,$06 Jump to #R$966C if *#R$96B6 is higher than #REGb.
  $9654,$01
  $9655,$01 #REGb=#REGa.
  $9656,$02 Jump to #R$966C if {} is not zero.
N $9658 #UDGTABLE { #MESSAGE$03(message-03) } UDGTABLE#
  $9658,$05 Call #R$7D97 using message block #N$03.
  $965D,$03 #REGa=*#R$96B7.
  $9660,$01 #REGd=#REGa.
  $9661,$04 Write #N$00 to *#R$96B7.
  $9665,$05 Return with #REGa=#N$02 if #REGd is not zero.
  $966A,$01 Increment #REGa by one.
  $966B,$01 Return.
N $966C
  $966C,$06 Jump to #R$967D if *#R$96B5 is higher than #REGb.
  $9672,$06 Write *#R$96B5 to *#R$96B7.
  $9678,$03 Jump to #R$9658 if #REGa is zero.
  $967B,$02 Jump to #R$9681.
  $967D,$04 Write #REGb to *#R$96B7.
  $9681,$03 Call #R$96A1.
N $9684 #UDGTABLE { #MESSAGE$02(message-02) } UDGTABLE#
  $9684,$05 Call #R$7D97 using message block #N$02.
  $9689,$02 #REGa=#N$01.
  $968B,$01 Return.
N $968C
  $968C,$06 Jump to #R$96B1 if *#R$96B7 is zero.
  $9692,$03 Call #R$96A1.
  $9695,$04 Write #N$00 to *#R$96B7.
N $9699 #UDGTABLE { #MESSAGE$03(message-03) } UDGTABLE#
  $9699,$05 Call #R$7D97 using message block #N$03.
  $969E,$02 #REGa=#N$02.
  $96A0,$01 Return.

c $96A1 Girl Add To Pot
@ $96A1 label=GirlAddToPot
R $96A1 A Value to add to Pot
  $96A1,$01 Store the value to add in #REGb.
  $96A2,$07 Subtract the value to add from *#R$96B6.
  $96A9,$07 And add the value onto *#R$96B4.
  $96B0,$01 Return.

c $96B1
  $96B1,$02 #REGa=#N$03.
  $96B3,$01 Return.

g $96B4 Pot Value
@ $96B4 label=PotValue
B $96B4,$01

g $96B5 Player Cash
@ $96B5 label=PlayerCash
B $96B5,$01

g $96B6 Girl Cash
@ $96B6 label=GirlCash
B $96B6,$01

g $96B7 Current "Raise" Value
@ $96B7 label=CurrentRaiseValue
B $96B7,$01

g $96B8 Current Round
@ $96B8 label=CurrentRound
B $96B8,$01

g $96B9

  $96C0

g $96C7 Players Hand?
@ $96C7 label=PlayersHand?
B $96C7,$05

g $96CC Girls Hand?
@ $96CC label=GirlsHand?
B $96CC,$05

c $96D1
  $96D1,$03 #REGa=*#R$949B.
  $96D4,$03 #REGhl=#R$971E.
  $96D7,$02 #REGb=#N$04.
  $96D9,$02 Return if *#REGhl is equal to #REGa.
  $96DB,$01 Increment #REGhl by one.
  $96DC,$02 Decrease counter by one and loop back to #R$96D9 until counter is zero.
  $96DE,$03 Call #R$9579.
  $96E1,$04 Jump to #R$96EC if #REGa is lower than #N$0A.
  $96E5,$07 Jump to #R$9705 if *#R$949B is equal to #N$03.
  $96EC,$04 #REGd=*#R$949C.
  $96F0,$03 #REGhl=#R$96CC.
  $96F3,$02 #REGb=#N$05.
  $96F5,$02 #REGc=#N$03.
  $96F7,$01 #REGa=*#REGhl.
  $96F8,$02,b$01 Keep only bits 0-3.
  $96FA,$03 Jump to #R$9701 #REGa is equal to #REGd.
  $96FD,$02 Write #N$FF to *#REGhl.
  $96FF,$01 Decrease #REGc by one.
  $9700,$01 Return if #REGc is zero.
  $9701,$01 Increment #REGhl by one.
  $9702,$02 Decrease counter by one and loop back to #R$96F7 until counter is zero.
  $9704,$01 Return.

  $9705,$03 #REGhl=#R$9540(#N$953F).
  $9708,$01 Increment #REGhl by one.
  $9709,$01 #REGa=*#REGhl.
  $970A,$01 Decrease #REGa by one.
  $970B,$02 Jump to #R$9708 until #REGa is zero.
  $970D,$03 Call #R$9473.
  $9710,$01 #REGd=#REGa.
  $9711,$03 #REGhl=#R$96CC(#N$96CB).
  $9714,$01 Increment #REGhl by one.
  $9715,$01 #REGa=*#REGhl.
  $9716,$02,b$01 Keep only bits 0-3.
  $9718,$03 Jump to #R$9714 if #REGa is not equal to #REGd.
  $971B,$02 Write #N$FF to *#REGhl.
  $971D,$01 Return.
B $971E,$01
B $971F,$01
B $9720,$01
B $9721,$01
  $9722,$04 #HTML(Jump to the address held by *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3D.html">ERR_SP</a>.)

b $9726 Graphics: Couch
@ $9726 label=Graphics_Couch
D $9726 Used by the routine at #R$7E6B.
N $9726 #UDGTABLE
. { #UDGARRAY$07,scale=$04,step=$07($9726-$97FE-$01-$38)@$9806-$9822(couch) }
. UDGTABLE#
  $9726,$E0,$07 Pixels.
  $9806,$1C,$07 Attributes.

c $9822 Jump To InPlay Girl Routine
@ $9822 label=JumpToInPlayGirlRoutine
  $9822,$06 Return if *#R$98E3 is equal to #N$11.
  $9828,$04 Increment *#R$98E3 by one.
  $982C,$03 #REGhl=#R$98E5(#N$98E0) (i.e. #R$98E5).
@ $982F label=FindCurrentGirlJumpRoutine
  $982F,$05 Increment #REGhl by five.
  $9834,$03 Decrease #REGa by one and jump back to #R$982F until #REGa is zero.
  $9837,$01 Jump to the address held by #REGhl.

c $9838 Print Girl
@ $9838 label=PrintGirl
  $9838,$01 Stash #REGbc on the stack.
  $9839,$03 Call #R$993A.
  $983C,$01 Restore #REGbc from the stack.
  $983D,$06 Shift #REGc left three times.
  $9843,$02 #REGhl=#REGde (using the stack).
@ $9845 label=GirlCopyAttributes_RowLoop
  $9845,$03 Stash #REGix and #REGbc on the stack.
@ $9848 label=GirlCopyAttributes_Loop
  $9848,$04 Copy a byte of data from *#REGhl to *#REGix+#N$00.
  $984C,$01 Increment #REGhl by one.
  $984D,$02 Increment #REGix by one.
  $984F,$02 Decrease the counter by one and loop back to #R$9848 until the counter is zero.
  $9851,$01 Restore #REGbc from the stack.
  $9852,$02 Restore #REGix from the stack.
  $9854,$05 #REGix+=#N($0020,$04,$04).
  $9859,$01 Decrease #REGc by one.
  $985A,$02 Jump back to #R$9845 until #REGc is zero.
  $985C,$01 Increment #REGc by one.
  $985D,$01 Return.

c $985E Graphics: Initialise Girl
@ $985E label=Graphics_InitialiseGirl
R $985E HL Pointer to #R$98E5 for referencing the graphic data
D $985E Used by the routines at #R$9975, #R$B613 and #R$CFBD.
  $985E,$02 #REGc=#N$58 (height).
  $9860,$02 #REGb=#N$20 (width).
  $9862,$03 #REGde=#N$4000 (screen buffer location).
  $9865,$04 #REGix=#N$5800 (attribute buffer location).
  $9869,$07 Increment *#R$98E4 by one.
  $9870,$02 Jump to #R$98D8.

c $9872 Graphics: Print Image Width - #N$0E
@ $9872 label=Graphics_Width14
R $9872 HL Pointer to #R$98E5 for referencing the graphic data
D $9872 Used by the routines at #R$A5D5, #R$A8C9, #R$ABBD and #R$B0E8.
  $9872,$02 #REGc=#N$30 (height).
  $9874,$02 #REGb=#N$0E (width).
  $9876,$03 #REGde=#N$40A8 (screen buffer location).
  $9879,$04 #REGix=#N$58A8 (attribute buffer location).
  $987D,$02 Jump to #R$98D8.

c $987F Graphics: Print Left Image Width - #N$09
@ $987F label=Graphics_Width09_Left
R $987F HL Pointer to #R$98E5 for referencing the graphic data
D $987F Used by the routines at #R$AEB1, #R$B3DC and #R$C9D5.
  $987F,$02 #REGc=#N$38 (height).
  $9881,$02 #REGb=#N$09 (width).
  $9883,$03 #REGde=#N$4080 (screen buffer location).
  $9886,$04 #REGix=#N$5880 (attribute buffer location).
  $988A,$02 Jump to #R$98D8.

c $988C Graphics: Print Right Image Width - #N$0F
@ $988C label=Graphics_Width0F
R $988C HL Pointer to #R$98E5 for referencing the graphic data
D $988C Used by the routines at #R$C273, #R$C624 and #R$CC0C.
  $988C,$02 #REGc=#N$38 (height).
  $988E,$02 #REGb=#N$0F (width).
  $9890,$03 #REGde=#N$4087 (screen buffer location).
  $9893,$04 #REGix=#N$5887 (attribute buffer location).
  $9897,$02 Jump to #R$98D8.

c $9899 Graphics: Print Left Image Width - #N$0F
@ $9899 label=Graphics_Width0F_Left
R $9899 HL Pointer to #R$98E5 for referencing the graphic data
D $9899 Used by the routine at #R$CC0C.
  $9899,$02 #REGc=#N$38 (height).
  $989B,$02 #REGb=#N$0F (width).
  $989D,$03 #REGde=#N$4084 (screen buffer location).
  $98A0,$04 #REGix=#N$5884 (attribute buffer location).
  $98A4,$02 Jump to #R$98D8.

c $98A6 Graphics: Print Right Image Width - #N$09
@ $98A6 label=Graphics_Width09_Right
R $98A6 HL Pointer to #R$98E5 for referencing the graphic data
D $98A6 Used by the routine at #R$DC1D.
  $98A6,$02 #REGc=#N$30 (height).
  $98A8,$02 #REGb=#N$09 (width).
  $98AA,$03 #REGde=#N$40A8 (screen buffer location).
  $98AD,$04 #REGix=#N$58A8 (attribute buffer location).
  $98B1,$02 Jump to #R$98D8.

c $98B3 Graphics: Print Image Width - #N$08
@ $98B3 label=Graphics_Width08
R $98B3 HL Pointer to #R$98E5 for referencing the graphic data
D $98B3 Used by the routine at #R$DE03.
  $98B3,$02 #REGc=#N$38 (height).
  $98B5,$02 #REGb=#N$08 (width).
  $98B7,$03 #REGde=#N$4081 (screen buffer location).
  $98BA,$04 #REGix=#N$5881 (attribute buffer location).
  $98BE,$02 Jump to #R$98D8.

c $98C0 Graphics: Print Image Width - #N$0A
@ $98C0 label=Graphics_Width0A
R $98C0 HL Pointer to #R$98E5 for referencing the graphic data
D $98C0 Used by the routine at #R$DFFB.
  $98C0,$02 #REGc=#N$30 (height).
  $98C2,$02 #REGb=#N$0A (width).
  $98C4,$03 #REGde=#N$40A7 (screen buffer location).
  $98C7,$04 #REGix=#N$58A7 (attribute buffer location).
  $98CB,$02 Jump to #R$98D8.

c $98CD Graphics: Print Image Width - #N$04
@ $98CD label=Graphics_Width04
R $98CD HL Pointer to #R$98E5 for referencing the graphic data
D $98CD Used by the routine at #R$E217.
  $98CD,$02 #REGc=#N$38 (height).
  $98CF,$02 #REGb=#N$04 (width).
  $98D1,$03 #REGde=#N$4084 (screen buffer location).
  $98D4,$04 #REGix=#N$5884 (attribute buffer location).

@ $98D8 label=Graphics_PrepToPrintGirl
  $98D8,$03 #HTML(Increment #REGhl by three to move the pointer past the <code>JP</code> command.)
  $98DB,$01 Stash the screen buffer pointer on the stack.
  $98DC,$03 Store a pointer to the stage data in #REGde.
  $98DF,$01 Restore the screen buffer pointer from the stack.
  $98E0,$03 Jump to #R$9838.

g $98E3 Current Stage
@ $98E3 label=CurrentStage
B $98E3,$01

g $98E4 Current Girl
@ $98E4 label=CurrentGirl
B $98E4,$01

w $98E5 Jump Table: Stage Data
@ $98E5 label=JumpTable_StageData
N $98E5 Stage #N($01+((#PC-$98E5)/$05)).
C $98E5,$03 Jump command to stage #N($01+((#PC-$98E5)/$05)).
  $98E8,$02 Stage data.
L $98E5,$05,$11

c $993A Print Graphic
@ $993A label=PrintGraphic
  $993A,$02 #REGa=#N$08.
  $993C,$03 Stash #REGhl, #REGbc and #REGaf on the stack.
  $993F,$01 #REGa=*#REGde.
  $9940,$01 Write #REGa to *#REGhl.
  $9941,$01 Increment #REGhl by one.
  $9942,$01 Increment #REGde by one.
  $9943,$02 Decrease counter by one and loop back to #R$993F until counter is zero.
  $9945,$03 Restore #REGaf, #REGbc and #REGhl from the stack.
  $9948,$01 Stash #REGaf on the stack.
  $9949,$01 #REGa=#REGh.
  $994A,$02 Reset bit 3 of #REGa.
  $994C,$04 Jump to #R$9960 if #REGa is not equal to #N$47.
  $9950,$05 Jump to #R$9960 if #REGl is lower than #N$E0.
  $9955,$01 Stash #REGde on the stack.
  $9956,$03 #REGde=#N($0020,$04,$04).
  $9959,$01 #REGhl+=#REGde.
  $995A,$02 Restore #REGde and #REGaf from the stack.
  $995C,$02 #REGa=#N$08.
  $995E,$02 Jump to #R$9966.
  $9960,$01 Restore #REGaf from the stack.
  $9961,$01 Decrease #REGa by one.
  $9962,$03 Call #R$996A if #REGa is zero.
  $9965,$01 Increment #REGh by one.
  $9966,$01 Decrease #REGc by one.
  $9967,$02 Jump to #R$993C until #REGc is zero.
  $9969,$01 Return.
  $996A,$01 Stash #REGde on the stack.
  $996B,$03 #REGde=#N($07E0,$04,$04).
  $996E,$01 Reset the flags.
  $996F,$02 #REGhl-=#REGde (with carry).
  $9971,$01 Restore #REGde from the stack.
  $9972,$02 #REGa=#N$08.
  $9974,$01 Return.

b $9975 Girl 1 Frame 1
@ $9975 label=Girl1_Frame1
D $9975 #PUSHS #UDGTABLE { #UDGARRAY$20,scale=$04,step=$20($9975-$A455-$01-$100)@$A475-$A5D5(girl-1-frame-1) } UDGTABLE# #POPS
  $9975,$0B00,$20 Pixels.
  $A475,$0160,$20 Attributes.

b $A5D5 Girl 1 Frame 2
@ $A5D5 label=Girl1_Frame2
D $A5D5 #PUSHS #UDGTABLE { #UDGARRAY$0E,scale=$04,step=$0E($A5D5-$A867-$01-$70)@$A875-$A8C9(girl-1-frame-2) } UDGTABLE# #POPS
  $A5D5,$02A0,$0E Pixels.
  $A875,$0054,$0E Attributes.

b $A8C9 Girl 1 Frame 3
@ $A8C9 label=Girl1_Frame3
D $A8C9 #PUSHS #UDGTABLE { #UDGARRAY$0E,scale=$04,step=$0E($A8C9-$AB5B-$01-$70)@$AB69-$ABBD(girl-1-frame-3) } UDGTABLE# #POPS
  $A8C9,$02A0,$0E Pixels.
  $AB69,$0054,$0E Attributes.

b $ABBD Girl 1 Frame 4
@ $ABBD label=Girl1_Frame4
D $ABBD #PUSHS #UDGTABLE { #UDGARRAY$0E,scale=$04,step=$0E($ABBD-$AE4F-$01-$70)@$AE5D-$AEB1(girl-1-frame-4) } UDGTABLE# #POPS
  $ABBD,$02A0,$0E Pixels.
  $AE5D,$0054,$0E Attributes.

b $AEB1 Girl 1 Frame 5
@ $AEB1 label=Girl1_Frame5
D $AEB1 #PUSHS #UDGTABLE { #UDGARRAY$09,scale=$04,step=$09($AEB1-$B0A0-$01-$48)@$B0A9-$B0E8(girl-1-frame-5) } UDGTABLE# #POPS
  $AEB1,$01F8,$09 Pixels.
  $B0A9,$003F,$09 Attributes.

b $B0E8 Girl 1 Frame 6
@ $B0E8 label=Girl1_Frame6
D $B0E8 #PUSHS #UDGTABLE { #UDGARRAY$0E,scale=$04,step=$0E($B0E8-$B37A-$01-$70)@$B388-$B3DC(girl-1-frame-6) } UDGTABLE# #POPS
  $B0E8,$02A0,$0E Pixels.
  $B388,$0054,$0E Attributes.

b $B3DC Girl 1 Frame 7
@ $B3DC label=Girl1_Frame7
D $B3DC #PUSHS #UDGTABLE { #UDGARRAY$09,scale=$04,step=$09($B3DC-$B5CB-$01-$48)@$B5D4-$B613(girl-1-frame-7) } UDGTABLE# #POPS
  $B3DC,$01F8,$09 Pixels.
  $B5D4,$003F,$09 Attributes.

b $B613 Girl 2 Frame 1
@ $B613 label=Girl2_Frame1
D $B613 #PUSHS #UDGTABLE { #UDGARRAY$20,scale=$04,step=$20($B613-$C0F3-$01-$100)@$C113-$C273(girl-2-frame-1) } UDGTABLE# #POPS
  $B613,$0B00,$20 Pixels.
  $C113,$0160,$20 Attributes.

b $C273 Girl 2 Frame 2
@ $C273 label=Girl2_Frame2
D $C273 #PUSHS #UDGTABLE { #UDGARRAY$0F,scale=$04,step=$0F($C273-$C5AC-$01-$78)@$C5BB-$C624(girl-2-frame-2) } UDGTABLE# #POPS
  $C273,$0348,$0F Pixels.
  $C5BB,$0069,$0F Attributes.

b $C624 Girl 2 Frame 3
@ $C624 label=Girl2_Frame3
D $C624 #PUSHS #UDGTABLE { #UDGARRAY$0F,scale=$04,step=$0F($C624-$C95D-$01-$78)@$C96C-$C9D5(girl-2-frame-3) } UDGTABLE# #POPS
  $C624,$0348,$0F Pixels.
  $C96C,$0069,$0F Attributes.

b $C9D5 Girl 2 Frame 4
@ $C9D5 label=Girl2_Frame4
D $C9D5 #PUSHS #UDGTABLE { #UDGARRAY$09,scale=$04,step=$09($C9D5-$CBC4-$01-$48)@$CBCD-$CC0C(girl-2-frame-4) } UDGTABLE# #POPS
  $C9D5,$01F8,$09 Pixels.
  $CBCD,$003F,$09 Attributes.

b $CC0C Girl 2 Frame 5
@ $CC0C label=Girl2_Frame5
D $CC0C #PUSHS #UDGTABLE { #UDGARRAY$0F,scale=$04,step=$0F($CC0C-$CF45-$01-$78)@$CF54-$CFBD(girl-2-frame-5) } UDGTABLE# #POPS
  $CC0C,$0348,$0F Pixels.
  $CF54,$0069,$0F Attributes.

b $CFBD Girl 3 Frame 1
@ $CFBD label=Girl3_Frame1
D $CFBD #PUSHS #UDGTABLE { #UDGARRAY$20,scale=$04,step=$20($CFBD-$DA9D-$01-$100)@$DABD-$DC1C(girl-3-frame-1) } UDGTABLE# #POPS
  $CFBD,$0B00,$20 Pixels.
  $DABD,$0160,$20 Attributes.

b $DC1D Girl 3 Frame 2
@ $DC1D label=Girl3_Frame2
D $DC1D #PUSHS #UDGTABLE { #UDGARRAY$09,scale=$04,step=$09($DC1D-$DDBD-$01-$48)@$DDCD-$DE02(girl-3-frame-2) } UDGTABLE# #POPS
  $DC1D,$01B0,$09 Pixels.
  $DDCD,$0036,$09 Attributes.

b $DE03 Girl 3 Frame 3
@ $DE03 label=Girl3_Frame3
D $DE03 #PUSHS #UDGTABLE { #UDGARRAY$08,scale=$04,step=$08($DE03-$DFBB-$01-$40)@$DFC3-$DFFA(girl-3-frame-3) } UDGTABLE# #POPS
  $DE03,$01C0,$08 Pixels.
  $DFC3,$0038,$08 Attributes.

b $DFFB Girl 3 Frame 4
@ $DFFB label=Girl3_Frame4
D $DFFB #PUSHS #UDGTABLE { #UDGARRAY$0A,scale=$04,step=$0A($DFFB-$E1D1-$01-$50)@$E1DB-$E216(girl-3-frame-4) } UDGTABLE# #POPS
  $DFFB,$01E0,$0A Pixels.
  $E1DB,$003C,$0A Attributes.

b $E217 Girl 3 Frame 5
@ $E217 label=Girl3_Frame5
D $E217 #PUSHS #UDGTABLE { #UDGARRAY$04,scale=$04,step=$04($E217-$E2F3-$01-$20)@$E2F7-$E312(girl-3-frame-5) } UDGTABLE# #POPS
  $E217,$00E0,$04 Pixels.
  $E2F7,$001C,$04 Attributes.

c $E313 Print Hand
@ $E313 label=PrintHand
R $E313 IX Pointer to either the players hand or the girls hand
  $E313,$02 Stash #REGix on the stack.
  $E315,$03 Copy the hand pointer to #REGhl using the stack.
N $E318 Starting from the first card.
  $E318,$05 Write #N$01 to *#R$E81F.
N $E31D Loop round each card in turn and print it to the screen.
@ $E31D label=PrintHand_Loop
  $E31D,$01 Stash the hand pointer on the stack.
  $E31E,$01 Fetch the card "value" and store it in #REGa.
  $E31F,$03 Call #R$E33A (which will print the card in position to the screen).
  $E322,$01 Restore the hand pointer from the stack.
  $E323,$01 Increment the hand pointer by one to point to the next card.
N $E324 Have all cards been printed yet? There are #N$05 in a hand.
  $E324,$07 Jump to #R$E331 if *#R$E81F is equal to #N$05.
  $E32B,$04 Increment the card position and update *#R$E81F count, as on the loop, we'll be looking at the next card.
  $E32F,$02 Jump to #R$E31D.
N $E331 #HTML(Housekeeping; restore the
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>
. value and the hand pointer to return.)
@ $E331 label=PrintHand_Finish
  $E331,$06 #HTML(Write #R$F4C9(#N$F3C9) (#R$F4C9) to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $E337,$02 Restore the original value of #REGix from the stack.
  $E339,$01 Return.

c $E33A Check Card Type
@ $E33A label=CheckCardType
R $E33A A Card value
  $E33A,$01 #REGb=#REGa.
  $E33B,$02,b$01 Keep only bits 0-3.
  $E33D,$04 Jump to #R$E3BD if #REGa is lower than #N$09.
  $E341,$04 Jump to #R$E3B8 if #REGa is equal to #N$0C.
N $E345 Anything else is a picture card, so work out what we're printing.
  $E345,$03 #REGhl=#R$E618.
  $E348,$03 #REGde=#N($0438,$04,$04).
  $E34B,$02 #REGa-=#N$08.
  $E34D,$02 #REGhl-=#REGde (with carry).
  $E34F,$01 #REGhl+=#REGde.
  $E350,$01 Decrease #REGa by one.
  $E351,$02 Jump to #R$E34F until #REGa is zero.
  $E353,$02 #REGa=#N$04.
  $E355,$02 Shift #REGb right.
  $E357,$01 Decrease #REGa by one.
  $E358,$02 Jump to #R$E355 until #REGa is zero.
  $E35A,$03 #REGde=#N($010E,$04,$04).
  $E35D,$01 #REGa=#N$00.
  $E35E,$02 #REGhl-=#REGde (with carry).
  $E360,$01 Increment #REGb by one.
  $E361,$01 #REGhl+=#REGde.
  $E362,$02 Decrease counter by one and loop back to #R$E361 until counter is zero.
  $E364,$03 #HTML(Write #REGhl to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $E367,$04 #REGhl+=#N($02F8,$04,$04).
  $E36B,$01 Stash #REGhl on the stack.
  $E36C,$06 Write #R$E39A to *#R$E563.
  $E372,$03 Call #R$E40D.
N $E375 Calculate the attribute buffer position for the card position currently
. being printed.
  $E375,$03 #REGa=*#R$E81F.
  $E378,$03 #REGhl=#N($0006,$04,$04).
  $E37B,$03 #REGde=#N$597B (attribute buffer location).
  $E37E,$01 Exchange the #REGde and #REGhl registers.
@ $E37F label=FindCardAttributePosition_Loop
  $E37F,$01 #REGhl+=#REGde.
  $E380,$01 Decrease #REGa by one.
  $E381,$02 Jump to #R$E37F until #REGa is zero.
  $E383,$01 Exchange the #REGde and #REGhl registers.
  $E384,$01 Restore the attributes pointer from the stack.
  $E385,$02 Set the card height (#N$05) to #REGc.
@ $E387 label=CopyCardAttributes_RowLoop
  $E387,$02 Set the card width (#N$06) to #REGb.
@ $E389 label=CopyCardAttributes_Loop
  $E389,$02 Copy an attribute byte from *#REGhl to *#REGde.
  $E38B,$02 Increment both #REGhl and #REGde by one.
  $E38D,$02 Decrease the width counter by one and loop back to #R$E389 until
. all the attributes in the row have been copied.
  $E38F,$01 Stash #REGhl on the stack.
N $E390 Move down one line, and to where the next row will start (#N$06 less
. than one row ~ #N$20).
  $E390,$05 #REGde+=#N($001A,$04,$04).
  $E395,$01 Restore #REGhl from the stack.
  $E396,$01 Decrease the height counter by one.
  $E397,$02 Jump to #R$E387 until the entire card has been printed.
  $E399,$01 Return.

b $E39A Graphics: Picture Card
@ $E39A label=Graphics_PictureCard
D $E39A This is UDG data which corresponds to the picture card UDGs.
.
. For the graphic data itself, see #R$E820.
.
.  #UDGTABLE {
.   #UDGS$06,$05(card-jack-diamonds)(
.     #LET(a=$E618+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-jack-hearts)(
.     #LET(a=$E726+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-jack-spades)(
.     #LET(a=$E834+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-jack-clubs)(
.     #LET(a=$E942+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. }
. {
.   #UDGS$06,$05(card-queen-diamonds)(
.     #LET(a=$EA50+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-queen-hearts)(
.     #LET(a=$EB5E+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-queen-spades)(
.     #LET(a=$EC6C+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-queen-clubs)(
.     #LET(a=$ED7A+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. }
. {
.   #UDGS$06,$05(card-king-diamonds)(
.     #LET(a=$EE88+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-king-hearts)(
.     #LET(a=$EF96+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-king-spades)(
.     #LET(a=$F0A4+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
.   |
.   #UDGS$06,$05(card-king-clubs)(
.     #LET(a=$F1B2+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
.
. Used by the routines at #R$E33A and #R$E40D.
  $E39A,$1E,$06

c $E3B8 Print Cards
@ $E3B8 label=PrintAceCard
  $E3B8,$02 #REGa-=#N$03.
  $E3BA,$03 Decrease #REGb by three.
@ $E3BD label=PrintNumberCard
  $E3BD,$01 #REGc=#REGb.
  $E3BE,$01 #REGb=#REGa.
  $E3BF,$01 Increment #REGb by one.
  $E3C0,$03 #REGde=#N($001E,$04,$04).
  $E3C3,$03 #REGhl=#R$E436.
  $E3C6,$01 #REGa=#N$00.
  $E3C7,$02 #REGhl-=#REGde (with carry).
  $E3C9,$01 #REGhl+=#REGde.
  $E3CA,$02 Decrease counter by one and loop back to #R$E3C9 until counter is zero.
  $E3CC,$03 Write #REGhl to *#R$E563.
  $E3CF,$02 #REGb=#N$04.
  $E3D1,$02 Shift #REGc right.
  $E3D3,$02 Decrease counter by one and loop back to #R$E3D1 until counter is zero.
  $E3D5,$04 Write #REGc to *#R$E562.
  $E3D9,$01 #REGb=#REGc.
  $E3DA,$01 Increment #REGb by one.
  $E3DB,$03 #REGde=#N($0058,$04,$04).
  $E3DE,$03 #REGhl=#R$E6BF.
  $E3E1,$01 #REGa=#N$00.
  $E3E2,$02 #REGhl-=#REGde (with carry).
  $E3E4,$01 #REGhl+=#REGde.
  $E3E5,$02 Decrease counter by one and loop back to #R$E3E4 until counter is zero.
  $E3E7,$01 Stash #REGde on the stack.
  $E3E8,$01 Restore #REGbc from the stack.
  $E3E9,$03 #REGde=#R$E667.
  $E3EC,$02 LDIR.
  $E3EE,$06 #HTML(Write #N$E35F to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $E3F4,$06 BRIGHT: ON.
  $E3FA,$06 Set INK: #INK$00.
  $E400,$07 Jump to #R$E40D if *#R$E562 is #N$02 or higher.
  $E407,$06 Set INK: #INK$02.
@ $E40D label=PrintCard
  $E40D,$03 Fetch the current *#R$E81F and store this in #REGa.
  $E410,$02 Each card is #N$06 character blocks in width, store this count in #REGc.
  $E412,$01 Set a counter in #REGb of the card position we're processing.
N $E413 Subtract #N$06 from #N$26 the number of times for the current card
. position. For example; position #N$01 is: #N$26 - (#N$01 * #N$06) = #N$20.
  $E413,$02 #REGa=#N$26.
@ $E415 label=FindCardPosition_Loop
  $E415,$01 #REGa-=#REGc.
  $E416,$02 Decrease card position counter by one and loop back to #R$E415 until the counter is zero.
  $E418,$01 #REGc=#REGa.
  $E419,$02 #REGb=#N$0C.
  $E41B,$04 #REGde=*#R$E563.
@ $E41F label=PrintCard_Loop
  $E41F,$01 Stash #REGde on the stack.
  $E420,$05 Jump to #R$E434 if #REGb is equal to #N$07.
  $E425,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0DD9.html#0DE2">#N$0DE2</a> (CL_SET).)
  $E428,$01 Restore #REGde from the stack.
  $E429,$01 Stash #REGbc on the stack.
  $E42A,$03 #REGbc=#N($0006,$04,$04).
  $E42D,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/1FFC.html#203C">PR_STRING</a>.)
  $E430,$01 Restore #REGbc from the stack.
  $E431,$01 Decrease #REGb by one.
  $E432,$02 Jump to #R$E41F.
@ $E434 label=PrintCard_Finish
  $E434,$01 Restore #REGde from the stack.
  $E435,$01 Return.

b $E436 Graphics: Cards
@ $E436 label=Graphics_CardTwo
D $E436 This is UDG data which corresponds to the UDGs defined at #R$E567.
.
. Used by the routine at #R$E3B8.
  $E436,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-two)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E454 label=Graphics_CardThree
  $E454,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-three)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E472 label=Graphics_CardFour
  $E472,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-four)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E490 label=Graphics_CardFive
  $E490,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-five)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E4AE label=Graphics_CardSix
  $E4AE,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-six)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E4CC label=Graphics_CardSeven
  $E4CC,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-seven)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E4EA label=Graphics_CardEight
  $E4EA,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-eight)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E508 label=Graphics_CardNine
  $E508,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-nine)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E526 label=Graphics_CardTen
  $E526,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-ten)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#
@ $E544 label=Graphics_CardAce
  $E544,$1E,$06 #UDGTABLE {
.   #UDGS$06,$05(card-ace)(
.     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))
.     #UDG({a})(*udg)
.     udg
.   )
. } UDGTABLE#

g $E562 Current Card Colour
@ $E562 label=CurrentCardColour
B $E562,$01

g $E563 Pointer Card UDG Data
@ $E563 label=PointerCardUDGData
D $E563 Pointer to the currently processed card UDG data.
W $E563,$02

i $E565
W $E565,$02

b $E567 Graphics: Card Data
@ $E567 label=Graphics_CardData
D $E567 Used by the routine at #R$E3B8.
  $E567,$08 #UDGTABLE { #N((#PC-$E35F)/$08) | #UDG(#PC) } UDGTABLE#
L $E567,$08,$20

  $E618

b $E667 Buffer: Card Data
@ $E667 label=Buffer_CardData
D $E667 Populated from one of:
. #TABLE(default)
. { #R$E6BF }
. { #R$E717 }
. { #R$E76F }
. { #R$E7C7 }
. TABLE#
  $E667,$08 #UDGTABLE { #N((#PC-$E35F)/$08) | #UDG(#PC) } UDGTABLE#
L $E667,$08,$0B

b $E6BF Graphics: Card Suits Data
@ $E6BF label=Graphics_DiamondsSuitData
@ $E717 label=Graphics_HeartsSuitData
@ $E76F label=Graphics_SpadesSuitData
@ $E7C7 label=Graphics_ClubsSuitData
D $E6BF The appropriate suit data is copied into #R$E667, it's not used from
. here directly.
  $E6BF,$58 #UDGTABLE #FOR$00,$0A,,$04(x,{ #N($61+x) | #UDG(#PC+x*$08) },) UDGTABLE#
L $E6BF,$58,$04

g $E81F Card Position
@ $E81F label=CardPosition
D $E81F Will be a value of; #N$01-#N$05 to indicate the currently "in-focus"
. card being processed/ evaluated.
B $E81F,$01

b $E820 Graphics: Picture Cards
@ $E820 label=Graphics_CardJackDiamondsData
  $E820,$08 #UDGTABLE { #N((#PC-$E618)/$08) | #UDG(#PC) } UDGTABLE#
L $E820,$08,$1E
@ $E910 label=Graphics_CardJackDiamondsAttributeData
  $E910,$1E,$06 Attributes.

@ $E92E label=Graphics_CardJackHeartsData
  $E92E,$08 #UDGTABLE { #N((#PC-$E726)/$08) | #UDG(#PC) } UDGTABLE#
L $E92E,$08,$1E
@ $EA1E label=Graphics_CardJackHeartsAttributeData
  $EA1E,$1E,$06 Attributes.

@ $EA3C label=Graphics_CardJackSpadesData
  $EA3C,$08 #UDGTABLE { #N((#PC-$E834)/$08) | #UDG(#PC) } UDGTABLE#
L $EA3C,$08,$1E
@ $EB2C label=Graphics_CardJackSpadesAttributeData
  $EB2C,$1E,$06 Attributes.

@ $EB4A label=Graphics_CardJackClubsData
  $EB4A,$08 #UDGTABLE { #N((#PC-$E942)/$08) | #UDG(#PC) } UDGTABLE#
L $EB4A,$08,$1E
@ $EC3A label=Graphics_CardJackClubsAttributeData
  $EC3A,$1E,$06 Attributes.

@ $EC58 label=Graphics_CardQueenDiamondsData
  $EC58,$08 #UDGTABLE { #N((#PC-$EA50)/$08) | #UDG(#PC) } UDGTABLE#
L $EC58,$08,$1E
@ $ED48 label=Graphics_CardQueenDiamondsAttributeData
  $ED48,$1E,$06 Attributes.

@ $ED66 label=Graphics_CardQueenHeartsData
  $ED66,$08 #UDGTABLE { #N((#PC-$EB5E)/$08) | #UDG(#PC) } UDGTABLE#
L $ED66,$08,$1E
@ $EE56 label=Graphics_CardQueenHeartsAttributeData
  $EE56,$1E,$06 Attributes.

@ $EE74 label=Graphics_CardQueenSpadesData
  $EE74,$08 #UDGTABLE { #N((#PC-$EC6C)/$08) | #UDG(#PC) } UDGTABLE#
L $EE74,$08,$1E
@ $EF64 label=Graphics_CardQueenSpadesAttributeData
  $EF64,$1E,$06 Attributes.

@ $EF82 label=Graphics_CardQueenClubsData
  $EF82,$08 #UDGTABLE { #N((#PC-$ED7A)/$08) | #UDG(#PC) } UDGTABLE#
L $EF82,$08,$1E
@ $F072 label=Graphics_CardQueenClubsAttributeData
  $F072,$1E,$06 Attributes.

@ $F090 label=Graphics_CardKingDiamondsData
  $F090,$08 #UDGTABLE { #N((#PC-$EE88)/$08) | #UDG(#PC) } UDGTABLE#
L $F090,$08,$1E
@ $F180 label=Graphics_CardKingDiamondsAttributeData
  $F180,$1E,$06 Attributes.

@ $F19E label=Graphics_CardKingHeartsData
  $F19E,$08 #UDGTABLE { #N((#PC-$EF96)/$08) | #UDG(#PC) } UDGTABLE#
L $F19E,$08,$1E
@ $F28E label=Graphics_CardKingHeartsAttributeData
  $F28E,$1E,$06 Attributes.

@ $F2AC label=Graphics_CardKingSpadesData
  $F2AC,$08 #UDGTABLE { #N((#PC-$F0A4)/$08) | #UDG(#PC) } UDGTABLE#
L $F2AC,$08,$1E
@ $F39C label=Graphics_CardKingSpadesAttributeData
  $F39C,$1E,$06 Attributes.

@ $F3BA label=Graphics_CardKingClubsData
  $F3BA,$08 #UDGTABLE { #N((#PC-$F1B2)/$08) | #UDG(#PC) } UDGTABLE#
L $F3BA,$08,$1E
@ $F4AA label=Graphics_CardKingClubsAttributeData
  $F4AA,$1E,$06 Attributes.

b $F4C8

b $F4C9 Custom Font
@ $F4C9 label=CustomFont
  $F4C9,$08 #UDG(#PC)
L $F4C9,$08,$60

c $F7CA Print 40 Column Text
@ $F7CA label=Print40ColumnText
R $F7CA BC Length of string to print
R $F7CA DE Pointer to string to print
  $F7CA,$06 #HTML(Write #R$F832 to *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C7B.html">UDG</a>.)
@ $F7D0 label=Print40ColumnText_Loop
  $F7D0,$04 Jump to #R$F7E0 if #REGbc is not zero.
  $F7D4,$03 #REGhl=#R$F831.
  $F7D7,$03 Return if bit 0 of *#REGhl is not set.
  $F7DA,$03 Print the UDG buffer to the screen.
  $F7DD,$02 Reset bit 0 of *#REGhl.
  $F7DF,$01 Return.
N $F7E0 Process the current letter.
@ $F7E0 label=Process40ColumnText
  $F7E0,$01 Fetch the current letter from the pointer in *#REGde, and store it in #REGa.
  $F7E1,$02 Subtract #N$20 from #REGa to "normalise" it. ASCII characters start
. from #N$20 ("SPACE") so this makes them #N$00-based.
  $F7E3,$02 Jump to #R$F7EE if #REGa is higher than zero.
N $F7E5 Where #REGa is less than zero, this means a control character needs to
. be actioned (e.g. setting INK/ PAPER/ PRINT AT/ etc).
  $F7E5,$02 Add #N$20 to the character to restore the "proper" ASCII value.
  $F7E7,$01 Stash the string pointer on the stack.
  $F7E8,$01 Action the current ASCII character.
  $F7E9,$01 Restore the string pointer from the stack.
  $F7EA,$01 Move onto the next letter in the string.
  $F7EB,$01 Decrease the string length counter by one.
  $F7EC,$02 Jump back to #R$F7D0.
N $F7EE We have a character we want to process, the UDGs for the characters begin at #R$F83A.
@ $F7EE label=Process40ColumnCharacter
  $F7EE,$01 Increment #REGa by one.
  $F7EF,$02 Stash the string pointer and string length on the stack.
N $F7F1 Locate the UDG character for the current letter.
  $F7F1,$03 #REGhl=#R$F832.
  $F7F4,$04 #REGhl+=#N($0008,$04,$04).
@ $F7F7 label=LocateSmallCharacter_Loop
  $F7F8,$01 Decrease #REGa by one.
  $F7F9,$02 Jump to #R$F7F7 until #REGa is zero.
  $F7FB,$03 #REGde=#R$F832.
N $F7FE The UDGs are still 8 bytes each, just for each only the first #N$04
. bits are used of the #N$08 total bits.
  $F7FE,$02 Set a UDG counter of #N$08.
@ $F800 label=SmallCharacterCopy_Loop
  $F800,$05 Test bit 0 of *#R$F831...
  $F805,$01 Fetch the UDG letter byte and store it in #REGa.
  $F806,$02 Jump to #R$F812 if bit 0 of *#R$F831 was not set.
N $F808 Shift the letter from the left-hand side of the UDG buffer over to the
. right-hand side.
  $F808,$02 Set a counter to shift by #N$04 bits.
@ $F80A label=ShiftToRightHandSide_Loop
  $F80A,$02 Shift #REGa right one bit.
  $F80C,$01 Decrease #REGc by one.
  $F80D,$02 Jump to #R$F80A until #REGc is zero.
M $F808,$07 Shift the bits of the current letter right four bits (move the
. letter from being on the left-hand side over to the right-hand side).
  $F80F,$01 Store the shifted letter in #REGc.
  $F810,$01 Fetch the current byte in #R$F832.
  $F811,$01 Merge the left and right parts together, the result is stored in #REGa.
M $F80F,$03 Merge the current byte in #R$F832 together with the shifted letter
. in #REGc. The result is stored in #REGa.
@ $F812 label=WriteSmallCharacterToBuffer
  $F812,$01 Write #REGa to the buffer.
  $F813,$01 Move onto the next byte of the UDG letter.
  $F814,$01 Move onto the next byte in the buffer.
  $F815,$02 Decrease the UDG byte counter by one and loop back to #R$F800 until the counter is zero.
N $F817 This toggle is the "magic" - it handles the left/ right flow of the code.
  $F817,$03 #REGa=*#R$F831.
  $F81A,$02,b$01 Flip bit 0.
  $F81C,$03 Write #REGa to *#R$F831.
M $F817,$08 Flip bit 0 of *#R$F831.
  $F81F,$02 Restore the string length and string pointer from the stack.
  $F821,$01 Move onto the next letter in the string.
  $F822,$01 Decrease the string length counter by one.
  $F823,$07 Jump to #R$F7D0 if bit 0 of *#R$F831 is set.
N $F82A Else, we can now print the UDG buffer at #R$F832 to the screen.
  $F82A,$01 Stash the string pointer on the stack.
  $F82B,$03 Print the UDG buffer to the screen.
  $F82E,$01 Restore the string pointer from the stack.
  $F82F,$02 Jump to #R$F7D0.

g $F831 Flag: Shift Letter
D $F831 Will be either #N$00 or #N$01, used to track what point the 40 column
. printing is at (if the code needs to print, or shift the lettering).
.
. Used by the routine at #R$F7CA.
@ $F831 label=FlagShiftLetter
B $F831,$01

g $F832 Buffer: Small Custom Font
@ $F832 label=BufferSmallFont
D $F832 This is a buffer where the letter doubles are merged together for
. printing to the screen.
.
. Used by the routine at #R$F7CA.
B $F832,$08 #UDG(#PC)

b $F83A Small Custom Font
@ $F83A label=SmallCustomFont
D $F83A Used by the routine at #R$F7CA.
N $F83A This is ASCII "SPACE" (#N$20), and everything below leads on from here (as ASCII).
  $F832,$08 #UDG(#PC)
L $F832,$08,$61,$02

c $FB3A Reset Theme Tune
@ $FB3A label=ResetThemeTune
  $FB3A,$06 Write #R$FD09 to *#R$FB55.
  $FB40,$06 Write #R$FE30 to *#R$FB59.
@ $FB46 label=HandlerThemeTune
  $FB46,$01 Disable interrupts.
@ $FB47 label=HandlerThemeTune_Loop
  $FB47,$03 Call #R$FB81.
  $FB4A,$03 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/028E.html">KEY_SCAN</a>.)
  $FB4D,$01 Increment #REGe by one.
  $FB4E,$02 Jump back to #R$FB47 until #REGe is zero.
  $FB50,$01 Enable interrupts.
  $FB51,$01 Return.

b $FB52
  $FB52,$01
  $FB53,$01
  $FB54,$01

w $FB55

w $FB57
B $FB5B
B $FB5D

c $FB5E
  $FB5E,$03 Load the next address into #REGde.
  $FB61,$01 Increment #REGde by one.
  $FB62,$01
  $FB63,$04 Jump to #R$FB79 if #REGa is equal to #N$40.

  $FB6A,$01 Return.

c $FB6B
  $FB6B,$01 #REGa=*#REGhl.
  $FB6C,$02 #REGa+=#N$0C.
  $FB6E,$01 #REGe=#REGa.
  $FB6F,$02 #REGd=#N$00.
  $FB71,$03 #REGhl=#R$FC0E.
  $FB74,$01 #REGhl+=#REGde.
  $FB75,$01 #REGh=*#REGhl.
  $FB76,$02 #REGl=#N$01.
  $FB78,$01 Return.

c $FB79
  $FB79,$01 Increment #REGhl by one.
  $FB7A,$01 #REGe=*#REGhl.
  $FB7B,$01 Increment #REGhl by one.
  $FB7C,$01 #REGd=*#REGhl.
  $FB7D,$02 Decrease #REGhl by two.
  $FB7F,$02 Jump to #R$FB62.

c $FB81 Play Theme Tune
@ $FB81 label=PlayThemeTune
  $FB81,$03 #REGhl=#R$FB55.
  $FB84,$03 Call #R$FB5E.
  $FB87,$03 Write #REGa to *#R$FB52.
  $FB8A,$03 #REGhl=#R$FB59.
  $FB8D,$03 Call #R$FB5E.
  $FB90,$03 Write #REGa to *#R$FB53.
  $FB93,$03 #REGhl=#R$FB52.
  $FB96,$03 Call #R$FB6B.
  $FB99,$02 Rotate #REGe left.
  $FB9B,$03 Jump to #R$FC44 if {} is lower.
  $FB9E,$01 Stash #REGhl on the stack.
  $FB9F,$03 #REGhl=#R$FB53.
  $FBA2,$03 Call #R$FB6B.
  $FBA5,$01 Restore #REGde from the stack.
  $FBA6,$01 #REGa=#REGh.
  $FBA7,$01 Decrease #REGa by one.
  $FBA8,$02 Jump to #R$FBAE if #REGa is not zero.
  $FBAA,$01 #REGa=#REGd.
  $FBAB,$01 Decrease #REGa by one.
  $FBAC,$02 Jump to #R$FBF0 if #REGa is zero.
  $FBAE,$03 #REGa=*#R$FB5D.
  $FBB1,$01 #REGc=#REGa.
  $FBB2,$02 #REGb=#N$00.
  $FBB4,$03 #REGa=*#R$FB54.
  $FBB7,$01 Exchange the #REGaf register with the shadow #REGaf register.
  $FBB8,$03 #REGa=*#R$FB54.

  $FBF0,$03 #REGa=*#R$FB5D.
  $FBF3,$01 Invert the bits in #REGa.
  $FBF4,$01 #REGc=#REGa.
  $FBF5,$02 Stash #REGbc and #REGaf on the stack.
  $FBF7,$02 #REGb=#N$00.
  $FBF9,$01 Stash #REGhl on the stack.
  $FBFA,$03 #REGhl=#N($0000,$04,$04).
  $FBFD,$06 Shift *#REGhl right three positions (with carry).
  $FC03,$01 No operation.
  $FC04,$01 Restore #REGhl from the stack.
  $FC05,$02 Decrease counter by one and loop back to #R$FBF9 until counter is zero.
  $FC07,$01 Decrease #REGc by one.
  $FC08,$03 Jump to #R$FBF9 until #REGc is zero.
  $FC0B,$02 Restore #REGaf and #REGbc from the stack.
  $FC0D,$01 Return.

b $FC0E

c $FC44

b $FCF1

b $FD09

b $FE30
