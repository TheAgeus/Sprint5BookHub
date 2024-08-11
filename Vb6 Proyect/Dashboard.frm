VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Dashboard 
   Caption         =   "Dashboard"
   ClientHeight    =   7755
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   15060
   LinkTopic       =   "Form1"
   ScaleHeight     =   7755
   ScaleWidth      =   15060
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton erase_book_btn 
      Caption         =   "Borrar libro"
      Height          =   315
      Left            =   11160
      TabIndex        =   22
      Top             =   1920
      Width           =   1575
   End
   Begin VB.CommandButton see_book_btn 
      Caption         =   "Ver libro"
      Height          =   375
      Left            =   11160
      TabIndex        =   21
      Top             =   1560
      Width           =   1575
   End
   Begin VB.CommandButton add_book_btn 
      Caption         =   "Agregar libro"
      Height          =   375
      Left            =   12720
      TabIndex        =   20
      Top             =   1560
      Width           =   1575
   End
   Begin VB.CommandButton erase_read_btn 
      Caption         =   "Borrar de leidos"
      Height          =   375
      Left            =   12720
      TabIndex        =   17
      Top             =   960
      Width           =   1575
   End
   Begin VB.CommandButton erase_wished_btn 
      Caption         =   "Borrar de deseados"
      Height          =   375
      Left            =   12720
      TabIndex        =   16
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton erase_fav_btn 
      Caption         =   "Borrar de favoritos"
      Height          =   375
      Left            =   12720
      TabIndex        =   15
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton add_to_alreadyread 
      Caption         =   "Agregar a ya leidos"
      Height          =   375
      Left            =   11160
      TabIndex        =   14
      Top             =   960
      Width           =   1575
   End
   Begin VB.CommandButton add_to_wished 
      Caption         =   "Agregar a deseados"
      Height          =   375
      Left            =   11160
      TabIndex        =   13
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton get_recommendations_btn 
      Caption         =   "Obtener lista de libros recomendados"
      Height          =   495
      Left            =   7920
      TabIndex        =   12
      Top             =   240
      Width           =   1815
   End
   Begin VB.CommandButton add_fav_btn 
      BackColor       =   &H00FFFFC0&
      Caption         =   "Agregar a favoritos"
      Height          =   375
      Left            =   11160
      MaskColor       =   &H00FFFFC0&
      TabIndex        =   11
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton alreadyread_list_btn 
      Caption         =   "Obtener lista de libros que ya lei"
      Height          =   495
      Left            =   6000
      TabIndex        =   10
      Top             =   720
      Width           =   1935
   End
   Begin VB.CommandButton wishbooklist_btn 
      Caption         =   "Obtener lista de libros que quiero leer"
      Height          =   495
      Left            =   6000
      TabIndex        =   9
      Top             =   240
      Width           =   1935
   End
   Begin VB.CommandButton get_fav_books_btn 
      Caption         =   "Obtener libros favoritos"
      Height          =   495
      Left            =   4560
      TabIndex        =   8
      Top             =   720
      Width           =   1455
   End
   Begin MSComctlLib.ListView books_listview 
      Height          =   5175
      Left            =   360
      TabIndex        =   7
      Top             =   2280
      Width           =   14415
      _ExtentX        =   25426
      _ExtentY        =   9128
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   16761024
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin VB.CommandButton fetch_books_btn 
      Caption         =   "Obtener todos los libros"
      Height          =   495
      Left            =   4560
      TabIndex        =   6
      Top             =   240
      Width           =   1455
   End
   Begin VB.Label fav_gener_lbl 
      Caption         =   "YOUR FAV GENER"
      Height          =   255
      Left            =   4680
      TabIndex        =   19
      Top             =   1680
      Width           =   5415
   End
   Begin VB.Label current_list_label 
      Caption         =   "Label4"
      Height          =   255
      Left            =   360
      TabIndex        =   18
      Top             =   1680
      Width           =   4215
   End
   Begin VB.Label emailLbl 
      Caption         =   "userid"
      Height          =   255
      Left            =   1320
      TabIndex        =   5
      Top             =   1200
      Width           =   3255
   End
   Begin VB.Label nameLbl 
      Caption         =   "userid"
      Height          =   255
      Left            =   1320
      TabIndex        =   4
      Top             =   720
      Width           =   3255
   End
   Begin VB.Label Label3 
      Caption         =   "Correo"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   1200
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Nombre"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   720
      Width           =   855
   End
   Begin VB.Label userIdLbl 
      Caption         =   "userid"
      Height          =   255
      Left            =   1320
      TabIndex        =   1
      Top             =   240
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "User ID"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "Dashboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub erase_book_btn_Click()

    Dim selectedItem As ListItem
    Set selectedItem = books_listview.selectedItem

    ' Check if an item is selected
    If Not selectedItem Is Nothing Then
        Dim bookId As String
        bookId = selectedItem.Text ' The ID of the selected book

        ' Confirm deletion
        Dim result As Integer
        result = MsgBox("¿Seguro que quieres borrar este libro?", vbYesNo + vbQuestion, "Confirm Deletion")
        
        If result = vbYes Then
            ' Perform the DELETE request
            Dim xmlhttp As Object
            Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
            
            xmlhttp.Open "DELETE", "https://localhost:7284/api/Books/" & bookId, False
            xmlhttp.setRequestHeader "Content-Type", "application/json"
            xmlhttp.send
            
            If xmlhttp.Status = 200 Then
                MsgBox "Libro borrado correctamente.", vbInformation
                books_listview.ListItems.Remove selectedItem.Index
            Else
                MsgBox xmlhttp.responseText, vbExclamation
            End If
        End If
    Else
        MsgBox "Selecciona un libro.", vbExclamation
    End If


End Sub

Private Sub erase_fav_btn_Click()

    Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas eliminar el libro " & selectedItem.SubItems(1) & " de tus favoritos?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            EraseFromFavorites CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If

End Sub

Private Sub erase_read_btn_Click()
    Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas eliminar el libro " & selectedItem.SubItems(1) & " de tus libros ya leidos?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            EraseFromAlreadyread CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub

Private Sub erase_wished_btn_Click()
    Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas eliminar el libro " & selectedItem.SubItems(1) & " de tu lista de deseos?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            EraseFromWished CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub



Private Sub Form_Load()
    'add columns to listview
   With books_listview.ColumnHeaders
    books_listview.View = lvwReport
        books_listview.ColumnHeaders.Add , , "ID", 1000
        books_listview.ColumnHeaders.Add , , "TITLE", 3000
        books_listview.ColumnHeaders.Add , , "AUTHOR", 2500
        books_listview.ColumnHeaders.Add , , "GENER", 1500
        books_listview.ColumnHeaders.Add , , "PUBLISHED IN", 1000
        books_listview.ColumnHeaders.Add , , "IS FAV", 1000
        books_listview.ColumnHeaders.Add , , "IS ALREADY READ", 2000
        books_listview.ColumnHeaders.Add , , "IS WISHED", 1000
    End With
    ' show witch list is being displayed
    Me.current_list_label.Caption = "Lista actual: ninguna"
End Sub

'with this function i get the fav gener of my user and i displayed it
Public Sub FetchFavGener()
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/Books/user/" & Me.userIdLbl.Caption & "/favorite-genre"

    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    Me.fav_gener_lbl.Caption = "Favorite gener -> " & response
    
    Set xmlhttp = Nothing
    
End Sub


Public Sub GetUser()

    Dim xmlhttp As Object
    Dim url As String
    Dim response As String

    ' Crear la URL de la API usando el User ID almacenado
    url = "https://localhost:7284/api/Users/" & Me.userIdLbl.Caption

    ' Crear el objeto XMLHTTP
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")

    ' Configurar la solicitud HTTP GET
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    
    ' Enviar la solicitud
    xmlhttp.send

    ' Obtener la respuesta
    response = xmlhttp.responseText

    ' Verificar si la respuesta no está vacía
    If Len(response) > 0 Then
        Dim userData() As String
        
        ' Dividir la cadena en un array usando ";" como delimitador
        userData = Split(response, ";")
        
        ' Ahora puedes acceder a cada parte de la cadena usando el array userData
        If UBound(userData) >= 1 Then
            Dim fullName As String
            Dim email As String
        
            fullName = userData(0)
            email = userData(1)
        
            Me.nameLbl.Caption = fullName
            Me.emailLbl.Caption = email
        Else
            MsgBox "Error: La respuesta no contiene los datos esperados."
        End If
    Else
        MsgBox "No se recibió respuesta de la API."
    End If

    ' Limpiar el objeto
    Set xmlhttp = Nothing
    
End Sub

' generate button for fetching all books
Public Sub FetchBooks()
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/Books/user/" & Me.userIdLbl.Caption

    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    
    Set xmlhttp = Nothing
    
    PopulateListView response, "ALL BOOKS"
End Sub


Private Sub add_fav_btn_Click()
     Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas agregar el libro " & selectedItem.SubItems(1) & " a tus favoritos?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            AddToFavorites CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub

Private Sub add_to_wished_Click()
    Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas agregar el libro " & selectedItem.SubItems(1) & " a tus deseados de leer?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            AddToWished CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub

Private Sub add_to_alreadyread_Click()
    Dim selectedItem As ListItem
    
    ' Verificar si hay un elemento seleccionado en el ListView
    If Not books_listview.selectedItem Is Nothing Then
        Set selectedItem = books_listview.selectedItem
        
        ' Obtener el ID del libro (suponiendo que el ID está en la primera columna)
        Dim bookId As String
        bookId = selectedItem.Text
        
        ' Mostrar un cuadro de diálogo para confirmar
        Dim response As VbMsgBoxResult
        response = MsgBox("¿Deseas agregar el libro " & selectedItem.SubItems(1) & " a tus ya leidos?", vbYesNo + vbQuestion, "Confirmación")

        If response = vbYes Then
            ' Enviar solicitud a la API
            AddToAlreadyread CInt(Me.userIdLbl.Caption), CInt(bookId)
        End If
    Else
        MsgBox "Por favor, seleccione un libro de la lista."
    End If
End Sub




Public Sub PopulateListView(data As String, label_caption As String)
    On Error Resume Next
    
    Dim items() As String
    Dim item As Variant
    Dim fields() As String
    Dim i As Integer

    ' Clear the ListView
    books_listview.ListItems.Clear

    ' Split the data into records
    items = Split(data, "|")
    
    ' Loop through each record
    For i = LBound(items) To UBound(items)
        fields = Split(items(i), ";")
        
        ' Add items to the ListView
        With books_listview.ListItems.Add(, , fields(0)) ' ID
            .SubItems(1) = fields(1) ' Title
            .SubItems(2) = fields(2) ' Author
            .SubItems(3) = fields(3) ' Gener
            .SubItems(4) = fields(4) ' Published Date
            .SubItems(5) = fields(5) ' is fav
            .SubItems(6) = fields(6) ' is already read
            .SubItems(7) = fields(7) ' is wished
        End With
    Next i
    
    ' to show or hidde buttons or controls, disable too, depending on witch list we are on
    Select Case label_caption
       Case "ALL BOOKS"
           add_fav_btn.Visible = True
           add_to_wished.Visible = True
           add_to_alreadyread.Visible = True
           erase_fav_btn.Visible = False
           erase_wished_btn.Visible = False
           erase_read_btn.Visible = False
       
       Case "ALREADY READ"
           add_to_alreadyread.Visible = False
           erase_read_btn.Visible = True
           add_fav_btn.Visible = False
           add_to_wished.Visible = False
           erase_fav_btn.Visible = False
           erase_wished_btn.Visible = False
       
       Case "WISHED BOOKS"
           add_to_wished.Visible = False
           erase_wished_btn.Visible = True
           add_fav_btn.Visible = False
           add_to_alreadyread.Visible = False
           erase_fav_btn.Visible = False
           erase_read_btn.Visible = False
       
       Case "FAVORITE BOOKS"
           add_to_wished.Visible = False
           erase_wished_btn.Visible = False
           add_fav_btn.Visible = False
           add_to_alreadyread.Visible = False
           erase_fav_btn.Visible = True
           erase_read_btn.Visible = False
    
        Case "RECOMMENDED BOOKS"
           add_to_wished.Visible = True
           erase_wished_btn.Visible = False
           add_fav_btn.Visible = True
           add_to_alreadyread.Visible = True
           erase_fav_btn.Visible = False
           erase_read_btn.Visible = False
        
    End Select
    
    Me.current_list_label.Caption = "Lista actual: " & label_caption
End Sub



' show or disable controls when we want to add a book in my form fot that
Private Sub add_book_btn_Click()
    bookDetailsForm.chkIsFav.Visible = False
    bookDetailsForm.chkIsAlreadyRead.Visible = False
    bookDetailsForm.chkIsWished.Visible = False
    bookDetailsForm.post_btn.Visible = True
    bookDetailsForm.txtBookID.Visible = False
    bookDetailsForm.Show
End Sub

' show or disable controls when were gonna see a book details form
Private Sub see_book_btn_Click()
    bookDetailsForm.txtBookID.Visible = True
    bookDetailsForm.chkIsFav.Visible = True
    bookDetailsForm.chkIsAlreadyRead.Visible = True
    bookDetailsForm.chkIsWished.Visible = True
    bookDetailsForm.chkIsFav.Visible = True
    bookDetailsForm.chkIsAlreadyRead.Visible = True
    bookDetailsForm.chkIsWished.Visible = True
    bookDetailsForm.chkIsFav.Enabled = False
    bookDetailsForm.chkIsAlreadyRead.Enabled = False
    bookDetailsForm.chkIsWished.Enabled = False
    bookDetailsForm.DisplayBookDetails
    bookDetailsForm.post_btn.Visible = False
End Sub

' fetch buttons

Private Sub get_fav_books_btn_Click()
    UserFavBooks.fetchfav
End Sub

Private Sub get_recommendations_btn_Click()
    UserRecommendedBooks.fetchRecommendedBooks
End Sub

Private Sub wishbooklist_btn_Click()
    UserWishBooks.fetchWishList
End Sub

Private Sub alreadyread_list_btn_Click()
    UserAlreadyreadBooks.fetchAlreadyreadList
End Sub


Private Sub fetch_books_btn_Click()
    FetchBooks
End Sub
