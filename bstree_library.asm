; include mem handling

size_n EQU 12
val EQU 0
izq EQU 4
der EQU 8

; PUSH <*node>
; PUSH <**root>
; CALL bstree_add
; ADD SP, 8
bstree_add:     PUSH BP
                MOV BP, SP

                PUSH EDX
                PUSH ECX
                PUSH EFX

                MOV EDX, [BP + 8]
                MOV ECX, [EDX]
                MOV EFX, [BP +12]

                CMP ECX, null
                JZ bstree_add_insert
                CMP [ECX + val], [EFX + val]
                JP  bstree_add_goizq
                 
                bstree_add_goder    ADD ECX, der
                                    PUSH EFX
                                    PUSH ECX
                                    CALL bstree_add
                                    ADD SP, 8 
                JMP bstree_add_fin
                bstree_add_goizq:   ADD ECX, izq 
                                    PUSH EFX
                                    PUSH ECX
                                    CALL bstree_add
                                    ADD SP, 8 
                JMP bstree_add_fin
                bstree_add_insert:  MOV [EDX], EFX
                bstree_add_fin:     POP EFX
                                    POP ECX
                                    POP EDX
MOV SP, BP
POP BP
RET


; PUSH <*root>
; CALL bstree_preorder
; ADD SP, 4
bstree_preorder:PUSH BP
                MOV  BP, SP

                PUSH EAX
                PUSH ECX
                PUSH EDX
                PUSH EEX

                MOV EEX, [BP+8]

                CMP EEX, null
                JZ bstree_preorder_fin

                MOV EDX, EEX
                LDH ECX, 1
                MOV CX, 4
                MOV EAX, 1 
                SYS 1

                PUSH [EEX + izq]
                CALL bstree_preorder
                ADD SP, 4

                PUSH [EEX + der]
                CALL bstree_preorder
                ADD SP, 4

                bstree_preorder_fin:POP EEX
                                    POP EDX
                                    POP ECX
                                    POP EAX
MOV SP, BP
POP BP
RET

; PUSH <*root>
; CALL bstree_inorder
; ADD SP, 4
bstree_inorder: PUSH BP
                MOV  BP, SP

                PUSH EAX
                PUSH ECX
                PUSH EDX
                PUSH EEX

                MOV EEX, [BP+8]

                CMP EEX, null
                JZ bstree_inorder_fin

                PUSH [EEX + izq]
                CALL bstree_inorder
                ADD SP, 4

                MOV EDX, EEX
                LDH ECX, 1
                MOV CX, 4
                MOV EAX, 1 
                SYS 1

                PUSH [EEX + der]
                CALL bstree_inorder
                ADD SP, 4

                bstree_inorder_fin: POP EEX
                                    POP EDX
                                    POP ECX
                                    POP EAX
MOV SP, BP
POP BP
RET


; PUSH <*root>
; CALL bstree_postorder
; ADD SP, 4
bstree_postorder: PUSH BP
                MOV  BP, SP

                PUSH EAX
                PUSH ECX
                PUSH EDX
                PUSH EEX

                MOV EEX, [BP+8]

                CMP EEX, null
                JZ bstree_postorder_fin

                PUSH [EEX + izq]
                CALL bstree_postorder
                ADD SP, 4

                PUSH [EEX + der]
                CALL bstree_postorder
                ADD SP, 4

                MOV EDX, EEX
                LDH ECX, 1
                MOV CX, 4
                MOV EAX, 1 
                SYS 1

                bstree_postorder_fin: POP EEX
                                    POP EDX
                                    POP ECX
                                    POP EAX
MOV SP, BP
POP BP
RET


; PUSH <val>
; PUSH <*root>
; CALL bstree_find
; ADD SP, 8
; @return EAX (1 : found | 0 not found)
bstree_find:    PUSH BP
                MOV BP, SP

                PUSH EDX
                PUSH ECX

                MOV EDX, [BP +12]
                MOV ECX, [BP +8]

                CMP ECX, null
                JZ bstree_find_notfound
                CMP [ECX + val], EDX
                JZ bstree_find_found

                CMP [ECX + val], EDX
                JP  bstree_find_goizq
                 
                bstree_find_goder:  PUSH EFX
                                    PUSH [ECX+der]
                                    CALL bstree_find
                                    ADD SP, 8 
                JMP bstree_find_fin
                bstree_find_goizq:  PUSH EFX
                                    PUSH [ECX+izq]
                                    CALL bstree_find
                                    ADD SP, 8 
                JMP bstree_find_fin
                bstree_find_found:  MOV EAX, 1
                                    JMP bstree_find_fin

                bstree_find_notfound: MOV EAX, 0
                bstree_find_fin:    POP EDX
                                    POP ECX
MOV SP, BP
POP BP
RET

; PUSH <*root>
; CALL bstree_niv
; ADD SP, 4
; @return EAX -> nivel
bstree_niv: PUSH BP
            MOV BP, SP

            PUSH EBX
            PUSH EFX
            
            MOV EFX, [BP + 8]
            
            CMP EFX, null
            JZ bstree_niv_zero

            PUSH [EFX + izq]
            CALL bstree_niv
            ADD SP, 4

            MOV EBX, EAX

            PUSH [EFX + izq]
            CALL bstree_niv
            ADD SP, 4

            CMP EBX, EAX
            JN bstree_niv_continue
            MOV EAX, EBX
            bstree_niv_continue:ADD EAX, 1
                                JMP bstree_niv_fin
            bstree_niv_zero:    MOV EAX, 0
            bstree_niv_fin:     POP EFX
                                POP EBX
MOV SP, BP
POP BP
RET

