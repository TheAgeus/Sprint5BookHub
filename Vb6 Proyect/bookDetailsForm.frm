VERSION 5.00
Begin VB.Form bookDetailsForm 
   Caption         =   "Book Details"
   ClientHeight    =   5370
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   6135
   LinkTopic       =   "Form1"
   ScaleHeight     =   5370
   ScaleWidth      =   6135
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox chkIsWished 
      Caption         =   "chkIsWished"
      Height          =   255
      Left            =   4440
      TabIndex        =   13
      Top             =   3720
      Width           =   1335
   End
   Begin VB.CheckBox chkIsAlreadyRead 
      Caption         =   "Ya lo leí ?"
      Height          =   255
      Left            =   2400
      TabIndex        =   12
      Top             =   3720
      Width           =   1695
   End
   Begin VB.CheckBox chkIsFav 
      Caption         =   "Es favorito ?"
      Height          =   255
      Left            =   360
      TabIndex        =   11
      Top             =   3720
      Width           =   1695
   End
   Begin VB.CommandButton post_btn 
      Caption         =   "Enviar"
      Height          =   375
      Left            =   480
      TabIndex        =   10
      Top             =   4680
      Width           =   5175
   End
   Begin VB.TextBox txtPublishedDate 
      Height          =   285
      Left            =   2760
      TabIndex        =   9
      Top             =   2880
      Width           =   2775
   End
   Begin VB.TextBox txtGener 
      Height          =   285
      Left            =   2760
      TabIndex        =   8
      Top             =   2280
      Width           =   2775
   End
   Begin VB.TextBox txtAuthor 
      Height          =   285
      Left            =   2760
      TabIndex        =   7
      Top             =   1680
      Width           =   2775
   End
   Begin VB.TextBox txtTitle 
      Height          =   285
      Left            =   2760
      TabIndex        =   6
      Top             =   1080
      Width           =   2775
   End
   Begin VB.TextBox txtBookID 
      Height          =   285
      Left            =   2760
      TabIndex        =   5
      Top             =   480
      Width           =   2775
   End
   Begin VB.Label Label5 
      Caption         =   "Fecha de publicación"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   2880
      Width           =   1575
   End
   Begin VB.Label Label4 
      Caption         =   "Género del libro"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Autor del libro"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   1680
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Título del libro"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Libro id"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   1215
   End
End
Attribute VB_Name = "bookDetailsForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub DisplayBookDetails()
    Dim selectedItem As ListItem
    Set selectedItem = Dashboard.books_listview.selectedItem
    
    ' Verificar si hay un elemento seleccionado
    If Not selectedItem Is Nothing Then
        Dim xmlhttp As Object
        Dim url As String
        Dim response As String
        Dim fields() As String

        ' Crear la URL para la API utilizando el BookID
        url = "https://localhost:7284/api/Books/" & selectedItem.Text & "/" & Dashboard.userIdLbl.Caption
        
        ' Crear el objeto XMLHTTP
        Set xmlhttp = CreateObject("MSXML2.XMLHTTP.6.0")
        
        ' Configurar la solicitud HTTP GET
        xmlhttp.Open "GET", url, False
        xmlhttp.setRequestHeader "Content-Type", "application/json"
        
        ' Enviar la solicitud
        xmlhttp.send
        
        ' Obtener la respuesta
        response = xmlhttp.responseText
        
        ' Verificar si la respuesta no está vacía
        If Len(response) > 0 Then
            ' Parsear la respuesta (asumiendo que los datos vienen en formato "ID;Title;Author;Gener;PublishedDate;IsFav;IsAlreadyRead;IsWished")
            fields = Split(response, ";")
            
            ' Poblar el formulario con los detalles del libro
            bookDetailsForm.txtBookID.Text = fields(0)
            bookDetailsForm.txtTitle.Text = fields(1)
            bookDetailsForm.txtAuthor.Text = fields(2)
            bookDetailsForm.txtGener.Text = fields(3)
            bookDetailsForm.txtPublishedDate.Text = fields(4)
            bookDetailsForm.chkIsFav.Value = IIf(fields(5) = "True", 1, 0)
            bookDetailsForm.chkIsAlreadyRead.Value = IIf(fields(6) = "True", 1, 0)
            bookDetailsForm.chkIsWished.Value = IIf(fields(7) = "True", 1, 0)
            
            ' Mostrar el formulario
            bookDetailsForm.Show
        Else
            MsgBox "No se encontraron detalles del libro en la API."
        End If
        
        ' Limpiar
        Set xmlhttp = Nothing
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub



Private Sub post_btn_click()
    Dim xmlhttp As Object
    Dim url As String
    Dim bookDetails As String
    Dim response As String
    
    ' Crear la URL para la API
    url = "https://localhost:7284/api/Books"
    
    ' Crear la cadena de detalles del libro en formato adecuado
    bookDetails = "title=" & bookDetailsForm.txtTitle.Text & _
                   "&author=" & bookDetailsForm.txtAuthor.Text & _
                   "&gener=" & bookDetailsForm.txtGener.Text & _
                   "&publishedDate=" & bookDetailsForm.txtPublishedDate.Text
    
    ' Crear el objeto XMLHTTP
    Set xmlhttp = CreateObject("MSXML2.XMLHTTP.6.0")
    
    ' Configurar la solicitud HTTP POST
    xmlhttp.Open "POST", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    
    ' Enviar la solicitud con los detalles del libro
    xmlhttp.send bookDetails
    
    ' Obtener la respuesta
    response = xmlhttp.responseText
    
    ' Manejar la respuesta
    If response = "Ese libro ya está registrado" Then
        MsgBox response
    Else
        MsgBox "Libro agregado con éxito."
    End If
    
    ' Limpiar
    Set xmlhttp = Nothing
End Sub

