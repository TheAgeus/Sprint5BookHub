Attribute VB_Name = "UserAlreadyreadBooks"
Public Sub fetchAlreadyreadList()

    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/UserAlreadyreadBooks/" & Dashboard.userIdLbl.Caption
    
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    
    
    Set xmlhttp = Nothing
    
    Dashboard.PopulateListView response, "ALREADY READ"

End Sub

Public Sub EraseFromAlreadyread(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserAlreadyreadBooks/" & userId & "/" & bookId
    
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
    If InStr(response, "No se encontró el libro en tus ya leidos.") > 0 Then
        MsgBox "No se encontró el libro en tus ya leidos."
    Else
        MsgBox "Libro eliminado de ya leidos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    
    fetchAlreadyreadList
End Sub

Public Sub AddToAlreadyread(userId As Integer, bookId As Integer)
    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    
    ' Crear la URL de la API
    url = "https://localhost:7284/api/UserAlreadyreadBooks/" & userId & "/" & bookId
    
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
    If InStr(response, "Ese libro ya está en tu lista de leidos.") > 0 Then
        MsgBox "Ese libro ya está en tu lista de leidos."
    Else
        MsgBox "Libro agregado a la lista de leidos con éxito."
    End If
    
    ' Limpiar el objeto
    Set xmlhttp = Nothing
    Dashboard.FetchBooks
End Sub
