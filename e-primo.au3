#pragma compile(Out, e-primo-etiquettes.exe)
; Uncomment to use the following icon. Make sure the file path is correct and matches the installation of your AutoIt install path.
#pragma compile(Icon, .\e-primo.ico)
;#pragma compile(ExecLevel, highestavailable)
;#pragma compile(Compatibility, win7)
;#pragma compile(UPX, False)
#pragma compile(FileDescription,G�n�rer des �tiquettes pour les identifiants)
#pragma compile(ProductName, e-primo - �tiquettes identifiants)
#pragma compile(ProductVersion, 1.0)
#pragma compile(FileVersion, 1.0.0.0, 1.0.0.0) ; The last parameter is optional.
#pragma compile(LegalCopyright, � B�atrice Arnou)
;#pragma compile(LegalTrademarks, '"Trademark something, and some text in "quotes" etc...')
#pragma compile(CompanyName, 'BA (TICE 49)')

#include <File.au3>
#include <Array.au3>
#include <EditConstants.au3>
#include <GuiConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIFiles.au3>


Main()

; Cr�ation de la fen�tre principale
Func Main()
    Local $fenetre

    GUICreate("�tiquettes identifiants e-primo",800,604)
	GUISetBkColor(0xCCCCCC)
	GUISetIcon("e-primo.ico")

	Local $iBkClr = 0xEEEEFF
	;GUICtrlSetDefBkColor($iBkClr)

   ; Enregistrer l'adresse du portail public
    GUICtrlCreateGroup(" 1 - Indiquez l'adresse internet de votre portail public ",3,5,794,94)
	GUICtrlSetBkColor(-1, $iBkClr)
	GUICtrlSetFont(-1, 10, 600)

   ; Juste pour la d�co (dessiner un cadre de couleur diff�rente)
    Local $ButtonDeco1 = GUICtrlCreateButton("", 4, 26, 792, 70)
    GUICtrlSetBkColor($ButtonDeco1, $iBkClr)
    GUICtrlSetState($ButtonDeco1, $GUI_DISABLE)

	Local $Label_URL1 = GUICtrlCreateLabel("Si vous souhaitez que l'adresse du portail public soit imprim�e sur l'�tiquette, saisissez-la ici :", 10, 36,330,40,$SS_RIGHT)
	GUICtrlSetFont($Label_URL1, 10)
	GUICtrlSetBkColor($Label_URL1, $iBkClr)

    ; R�cup�ration de l'url du portail public si elle a d�j� �t� enregistr�e
	$iniFile = @LocalAppDataDir & "\" & "etiq-eprimo.ini"
    $iniURL = IniRead($iniFile, "General", "URL", "http://")
	Local $URL = GUICtrlCreateInput($iniURL, 350, 50, 435, 20,$ES_LOWERCASE)

       ; Infos n�cessaires pour la g�n�ration des �tiquettse
	GUICtrlCreateGroup(" 2 - S�lectionnez le fichier contenant les identifiants ",3,100,794,500)
	GUICtrlSetBkColor(-1, $iBkClr)
	GUICtrlSetFont(-1, 10, 600)

    Local $ButtonFalse1 = GUICtrlCreateButton("", 4, 120, 792, 430)
    GUICtrlSetBkColor($ButtonFalse1, $iBkClr)
    GUICtrlSetState($ButtonFalse1, $GUI_DISABLE)

	; Explications
	$explications = "Le fichier doit avoir �t� g�n�r� depuis l'interface d'administration d'e-primo (Administration / Droits d'utilisateurs et droits d'acc�s)." & Chr(10) & "Il doit �tre enregistr� au format .txt et doit contenir les informations suivantes :"
    Local $Label_Explications = GUICtrlCreateLabel($explications, 16, 126,770,40,$SS_LEFT)
	GUICtrlSetFont($Label_Explications, 10)
	GUICtrlSetBkColor($Label_Explications, $iBkClr)

	; Capture d'�cran
	GUICtrlCreatePic("identifiants.jpg", 123, 166,545,189)

	; Explications 2
	$explications2 = "La premi�re ligne doit obligatoirement contenir les noms des colonnes (Nom   Nom d'utilisateur   Mot de passe    Adresse e-mail)." & Chr(10) & "Ne modifiez pas l'espacement des mots (pas de suppression des espaces)."
    Local $Label_Explications2 = GUICtrlCreateLabel($explications2, 16, 366,770,40,$SS_LEFT)
	GUICtrlSetFont($Label_Explications2, 10)
	GUICtrlSetBkColor($Label_Explications2, $iBkClr)

	; Tutoriel vid�o
	$tuto = "Pour plus d'explications concernant la pr�paration du fichier, consultez le tutoriel vid�o ci-contre." & Chr(10) & Chr(10) & "Si votre fichier est pr�t, cliquez sur ""G�n�rer les �tiquettes""."
    Local $Label_Tuto = GUICtrlCreateLabel($tuto, 16, 412,480,70,$SS_LEFT)
	GUICtrlSetFont($Label_Tuto, 10)
	GUICtrlSetBkColor($Label_Tuto, $iBkClr)

	; Tuto vid�o
	Local $idPic = GUICtrlCreatePic("tuto.jpg", 520, 400,252,136)

	Local $Button_Convertir = GUICtrlCreateButton("G�n�rer les �tiquettes", 130, 494, 250, 40)
	GUICtrlSetFont($Button_Convertir, 13, 600)
    GUICtrlSetResizing($Button_Convertir, $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKHCENTER)

	; Bouton Quitter
    $Button_Quitter = GUICtrlCreateButton("Quitter", 4, 555, 792, 40)
	GUICtrlSetFont($Button_Quitter, 13, 600)
    GUICtrlSetResizing($Button_Quitter, $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)

	GUISetState(@SW_SHOW)

 	If not FileExists(@ScriptDir & "\eprimo.src") or not FileExists(@ScriptDir & "\php-win.exe") or not FileExists(@ScriptDir & "\php5ts.dll") Then
	   MsgBox(16, "Erreur", "Le programme ne trouve pas certains fichiers indispensables � son fonctionnement." & @CRLF & "Veuillez r�installer le logiciel.")
	   exit
	Endif

    ; Run the GUI until the dialog is closed
    While 1
        $msg = GUIGetMsg()
		Select
            Case $msg = $GUI_EVENT_CLOSE
                ExitLoop
			Case $msg = $idPic
                ShellExecute("https://mediacad.ac-nantes.fr/m/1018/d/i","","","open")
			Case $msg = $Button_Convertir
                ConvertitFichier(GUICtrlRead($URL))
            Case $msg = $Button_Quitter
                ExitLoop
        EndSelect
    WEnd
    GUIDelete()
EndFunc   ;==>Main


Func ConvertitFichier($url)
    Local $result
    Local $message = "O� se trouve le fichier contenant les identifiants ?"
    Local $var = FileOpenDialog($message, "", "identifiants.txt (*.txt)")

    If @error Then
       MsgBox(48, "S�lection de fichier", "Vous devez indiquer o� se trouve le fichier contenant les identifiants !")
    Else
	  Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)
      $result = FileCopy ($var,  $sFilePath,1)

  	  Local $identifiants =  "etiquettes-e-primo-" & @YEAR & ".pdf"

	  ; Enregistrement dans un fichier ini de l'adresse du portail public.
	  ; Si l'info n'est pas renseign�e, on supprime le fichier.
      $iniFile = @LocalAppDataDir & "\" & "etiq-eprimo.ini"
      If ($url <> 'http://') Then
	     $url_portail_public = $url
		 IniWrite($iniFile, "General", "URL", $url)
	  Else
		 If FileExists($iniFile) Then
			$result = FileDelete($iniFile)
		 EndIf
		 $url_portail_public = ''
	  Endif

       Local $commande = Chr(34) & @ScriptDir & "\php-win.exe" & Chr(34) & " " & Chr(34) & @ScriptDir & "\eprimo.src" & Chr(34) & " " & Chr(34) & $sFilePath & Chr(34) & " " & Chr(34) & $url_portail_public & Chr(34)
	   RunWait($commande,@ScriptDir)

	   If FileExists($sFilePath) Then

	      ProgressOn("Progression", "Conversion en cours...", "0%")
          For $i = 10 To 100 Step 10
             Sleep(100)
             ProgressSet($i, $i & " %")
          Next
          ProgressSet(100, "100%", "Termin�")
          Sleep(1000)
          ProgressOff()

		  Local $iFileExists = FileExists(@TempDir & "\" & $identifiants)

		  ; Est-ce que le fichier .pdf est disponible ou non ?
;~           If $iFileExists Then
;~ 			 MsgBox($MB_SYSTEMMODAL, "", "Le fichier existe." & @CRLF & "Retour : " & $iFileExists)
;~           Else
;~              MsgBox($MB_SYSTEMMODAL, "", "Le fichier n'existe pas." & @CRLF & "Retour : " & $iFileExists)
;~ 		  EndIf

	      Local $sFileName = FileSaveDialog("Enregistrer sous...", @DesktopDir, "(*.pdf)", 18, $identifiants)
          If @error Then Exit
 		  $result = FileMove(@TempDir & "\" & $identifiants, $sFileName,1)
          $Answer = MsgBox(36,"Identifiants e-primo","Les �tiquettes sont disponibles dans le fichier : " & $sFileName & ". " & @CRLF & @CRLF & "Voulez-vous l'ouvrir maintenant ?")
 		  If $Answer = $IDYES Then
			  ShellExecute($sFileName,"",@TempDir,"open")
          Endif

		  ; Suppression des fichiers temporaires :
		  If FileExists($sFilePath) Then
 	         $result = FileDelete($sFilePath)
   	      Endif

		 ; Suppression des fichiers temporaires :
		  If FileExists(@TempDir & "\identeprimo.txt") Then
 	         $result = FileDelete(@TempDir & "\identeprimo.txt")
   	      Endif

	   Else
	      MsgBox(16,"Identifiants e-primo","Erreur !!!  Le fichier envoy� est-il le bon ?")
       Endif  ; ==> Si le fichier $identifiants a bien �t� g�n�r�.
   Endif  ; ==> Aucun fichier choisi
EndFunc   ; ==> ConvertitFichier
