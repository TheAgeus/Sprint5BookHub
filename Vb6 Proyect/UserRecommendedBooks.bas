Attribute VB_Name = "UserRecommendedBooks"
Public Sub fetchRecommendedBooks()

    Dim xmlhttp As Object
    Dim url As String
    Dim response As String
    Dim i As Integer

    url = "https://localhost:7284/api/Books/user/" & Dashboard.userIdLbl.Caption & "/random-books"
    
    Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlhttp.Open "GET", url, False
    xmlhttp.setRequestHeader "Content-Type", "application/json"
    xmlhttp.send

    response = xmlhttp.responseText
    
    Set xmlhttp = Nothing
    
    Dashboard.PopulateListView response, "RECOMMENDED BOOKS"

End Sub
