Attribute VB_Name = "UserFavBooks"
Public Sub fetchfav()

    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/UserFavBooks/" & Dashboard.userIdLbl.Caption
    
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    
    
    Set xmlhttp = Nothing
    
    Dashboard.PopulateListView response, "FAVORITE BOOKS"

End Sub

Public Sub EraseFromFavorites(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserFavBooks/" & userId & "/" & bookId
    
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
    If InStr(response, "No se encontró el libro en tus favoritos.") > 0 Then
        MsgBox "No se encontró el libro en tus favoritos."
    Else
        MsgBox "Libro eliminado de favoritos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    
    fetchfav
End Sub

Public Sub AddToFavorites(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserFavBooks/" & userId & "/" & bookId
    
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
    If InStr(response, "Ese libro ya es tu favorito") > 0 Then
        MsgBox "Este libro ya es tu favorito."
    Else
        MsgBox "Libro agregado a favoritos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    Dashboard.FetchBooks
End Sub
