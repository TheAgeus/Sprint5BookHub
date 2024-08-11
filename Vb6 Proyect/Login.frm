VERSION 5.00
Begin VB.Form Login 
   Caption         =   "Login"
   ClientHeight    =   3105
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   3510
   LinkTopic       =   "Form1"
   ScaleHeight     =   3105
   ScaleWidth      =   3510
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton LoginBtn 
      Caption         =   "Enviar"
      Height          =   375
      Left            =   960
      TabIndex        =   2
      Top             =   2040
      Width           =   1695
   End
   Begin VB.TextBox passwordInput 
      Height          =   285
      Left            =   840
      TabIndex        =   1
      Text            =   "12345"
      Top             =   1080
      Width           =   1815
   End
   Begin VB.TextBox EmailInput 
      Height          =   285
      Left            =   840
      TabIndex        =   0
      Text            =   "ageus94@gmail.com"
      Top             =   480
      Width           =   1815
   End
End
Attribute VB_Name = "Login"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False




Private Sub LoginBtn_Click()
    Dim email As String
    Dim password As String
    Dim jsonBody As String
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String

    ' Obtener los valores del formulario
    email = EmailInput.Text
    password = passwordInput.Text

    ' Crear el cuerpo JSON
    jsonBody = "{""email"": """ & email & """, ""password"": """ & password & """}"

    ' Crear la URL de la API
    url = "https://localhost:7284/api/Users/login"

    ' Crear el objeto XMLHTTP
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")

    ' Configurar la solicitud HTTP POST
    xmlhttp.Open "POST", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    
    ' Enviar la solicitud con el cuerpo JSON
    xmlhttp.send jsonBody

    ' Obtener la respuesta
    response = xmlhttp.responseText

    If IsNumeric(response) Then
        
        Load Dashboard
        Dashboard.userIdLbl.Caption = response
        Dashboard.Show
        Dashboard.GetUser
        Dashboard.FetchFavGener
    Else
        ' Mostrar la respuesta (o manejarla según tus necesidades)
        If response = "Usuario o contraseña incorrectos." Then
            MsgBox "Usuario o contraseña incorrectos."
        Else
            MsgBox "Respuesta desconocida: " & response
        End If
    End If
    

    ' Limpiar el objeto
    Set xmlhttp = Nothing
End Sub
