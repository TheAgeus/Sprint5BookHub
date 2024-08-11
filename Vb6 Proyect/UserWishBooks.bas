Attribute VB_Name = "UserWishBooks"
Public Sub fetchWishList()

    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/UserWishBooks/" & Dashboard.userIdLbl.Caption
    
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    
    
    Set xmlhttp = Nothing
    
    Dashboard.PopulateListView response, "WISHED BOOKS"

End Sub

Public Sub EraseFromWished(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserWishBooks/" & userId & "/" & bookId
    
    ' Crear el objeto XMLHTTP
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    
    ' Configurar la solicitud HTTP POST
    xmlhttp.Open "DELETE", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    
    ' Enviar la solicitud
    xmlhttp.send
    
    ' Obtener la respuesta
    response = xmlhttp.responseText
    
    ' Mostrar el mensaje según la respuesta de la API
    If InStr(response, "No se encontró el libro en la lista de deseos.") > 0 Then
        MsgBox "No se encontró el libro en la lista de deseos."
    Else
        MsgBox "Libro eliminado de lista de deseos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    
    fetchWishList
End Sub

Public Sub AddToWished(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserWishBooks/" & userId & "/" & bookId
    
    ' Crear el objeto XMLHTTP
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    
    ' Configurar la solicitud HTTP POST
    xmlhttp.Open "POST", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    
    ' Enviar la solicitud
    xmlhttp.send
    
    ' Obtener la respuesta
    response = xmlhttp.responseText
    
    ' Mostrar el mensaje según la respuesta de la API
    If InStr(response, "Ese libro ya está en tu lista de deseos.") > 0 Then
        MsgBox "Ese libro ya está en tu lista de deseos."
    Else
        MsgBox "Libro agregado a la lista de deseos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    Dashboard.FetchBooks
End Sub
