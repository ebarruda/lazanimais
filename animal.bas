5 REM ADAPTADO DE: http://www.classicbasicgames.org/basic/creative/animal.bas - roda no Chipmunk BASIC
10 PRINT TAB(32);"ANIMAIS"
20 PRINT TAB(15);"CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
30 PRINT: PRINT: PRINT
40 PRINT "JOGO ANIMAIS"
45 PRINT
50 PRINT "PENSE EM UM ANIMAL E O COMPUTADOR IRA TENTAR ADIVINHAR."
60 PRINT
70 DIM A$(200)
80 FOR I=0 TO 3
90 READ A$(I)
100 NEXT I
110 N=VAL(A$(0))
120 REM          SECAO PRINCIPAL DE CONTROLE
130 INPUT "VOCE PENSOU EM UM ANIMAL? (S-SIM/L-LISTA): ";A$
135 A$=UCASE$(LEFT$(A$,1))
140 IF A$="L" THEN 600
150 IF A$<>"S" THEN 120
160 K=1
170 GOSUB 390
180 IF LEN(A$(K))=0 THEN 999
190 IF LEFT$(A$(K),2)="\Q" THEN 170
200 PRINT "O ANIMAL E' ";RIGHT$(A$(K),LEN(A$(K))-2);"? (S-SIM/N-NAO):"
210 INPUT A$
220 A$=UCASE$(LEFT$(A$,1))
230 IF LEFT$(A$,1)="S" THEN PRINT "PORQUE NAO TENTA OUTRO ANIMAL?": GOTO 120
240 INPUT "ESCREVA O NOME DO ANIMAL QUE VOCE PENSOU: ";V$
245 V$=UCASE$(V$)
250 PRINT "POR FAVOR, DIGITE UMA PERGUNTA QUE DIFERENCIE UM(A)"
260 PRINT V$;" DE UM(A) ";RIGHT$(A$(K),LEN(A$(K))-2)
270 INPUT X$
275 X$=UCASE$(X$)
280 PRINT "PARA UM(A) ";V$;" A RESPOSTA SERIA (S-SIM/N-NAO): ";
290 INPUT A$
300 A$=UCASE$(LEFT$(A$,1)): IF A$<>"S" AND A$<>"N" THEN 280
310 IF A$="S" THEN B$="N"
320 IF A$="N" THEN B$="S"
330 Z1=VAL(A$(0))
340 A$(0)=STR$(Z1+2)
350 A$(Z1)=A$(K)
360 A$(Z1+1)="\A"+V$
370 A$(K)="\Q"+X$+"\"+A$+STR$(Z1+1)+"\"+B$+STR$(Z1)+"\"
380 GOTO 120
390 REM     SUB-ROTINA PARA IMPRIMIR PERGUNTAS
400 Q$=A$(K)
410 FOR Z=3 TO LEN(Q$)
415 IF MID$(Q$,Z,1)<>"\" THEN PRINT MID$(Q$,Z,1);: NEXT Z
420 INPUT C$
430 C$=UCASE$(LEFT$(C$,1))
440 IF C$<>"S" AND C$<>"N" THEN 410
450 T$="\"+C$
455 FOR X=3 TO LEN(Q$)-1
460 IF MID$(Q$,X,2)=T$ THEN 480
470 NEXT X
475 STOP
480 FOR Y=X+1 TO LEN(Q$)
490 IF MID$(Q$,Y,1)="\" THEN 510
500 NEXT Y
505 STOP
510 K=VAL(MID$(Q$,X+2,Y-X-2))
520 RETURN
530 DATA "4","\QELE NADA\S2\N3\","\APEIXE","\APASSARO"
600 PRINT:PRINT "ANIMAIS QUE CONHE�O SAO:"
605 X=0
610 FOR I=1 TO 200
620 IF LEFT$(A$(I),2)<>"\A" THEN 650
624 PRINT TAB(15*X);
630 FOR Z=3 TO LEN(A$(I))
640 IF MID$(A$(I),Z,1)<>"\" THEN PRINT MID$(A$(I),Z,1);: NEXT Z
645 X=X+1: IF X=4 THEN X=0: PRINT
650 NEXT I
660 PRINT
670 PRINT
680 GOTO 120
999 END
