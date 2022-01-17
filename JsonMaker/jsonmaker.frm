VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "JsonMaker"
   ClientHeight    =   10680
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   10725
   LinkTopic       =   "Form1"
   ScaleHeight     =   10680
   ScaleWidth      =   10725
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.TextBox txt_description 
      Height          =   495
      Left            =   1560
      TabIndex        =   16
      Text            =   "https://laodao.io"
      Top             =   2400
      Width           =   8655
   End
   Begin VB.TextBox txt_attr2 
      Height          =   735
      Left            =   1560
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   14
      Text            =   "jsonmaker.frx":0000
      Top             =   7680
      Width           =   8655
   End
   Begin VB.TextBox txt_external_url 
      Height          =   495
      Left            =   1560
      TabIndex        =   12
      Text            =   "https://laodao.io"
      Top             =   1680
      Width           =   8655
   End
   Begin VB.TextBox txt_image1 
      Height          =   495
      Left            =   1560
      TabIndex        =   8
      Text            =   "ipfs://QmRA2mipvfAM21JQWVPnxZbBu94fkCjgSaBs7CfBV1YmG2/"
      Top             =   960
      Width           =   8655
   End
   Begin VB.TextBox txt_name 
      Height          =   495
      Left            =   1560
      TabIndex        =   6
      Text            =   "LaoDao OG #"
      Top             =   240
      Width           =   8655
   End
   Begin VB.TextBox txt_attr 
      Height          =   4215
      Left            =   1560
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   4
      Text            =   "jsonmaker.frx":0027
      Top             =   3240
      Width           =   8655
   End
   Begin VB.CommandButton JsonMker 
      Caption         =   "Maker"
      Height          =   735
      Left            =   4800
      TabIndex        =   3
      Top             =   9480
      Width           =   1455
   End
   Begin VB.TextBox txt_end 
      Height          =   495
      Left            =   4200
      TabIndex        =   1
      Text            =   "79"
      Top             =   8760
      Width           =   1215
   End
   Begin VB.TextBox txt_start 
      Height          =   495
      Left            =   2640
      TabIndex        =   0
      Text            =   "0"
      Top             =   8760
      Width           =   1215
   End
   Begin VB.Label Label5 
      Height          =   375
      Left            =   240
      TabIndex        =   15
      Top             =   10200
      Width           =   3615
   End
   Begin VB.Label txt_attributes2 
      Alignment       =   1  'Right Justify
      Caption         =   "description2"
      Height          =   375
      Left            =   240
      TabIndex        =   13
      Top             =   7920
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "external_url"
      Height          =   375
      Left            =   120
      TabIndex        =   11
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label txt_attributes 
      Alignment       =   1  'Right Justify
      Caption         =   "attributes"
      Height          =   375
      Left            =   240
      TabIndex        =   10
      Top             =   4440
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   "description"
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   2520
      Width           =   1095
   End
   Begin VB.Label txt_image 
      Alignment       =   1  'Right Justify
      Caption         =   "image"
      Height          =   375
      Left            =   480
      TabIndex        =   7
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "name"
      Height          =   375
      Left            =   480
      TabIndex        =   5
      Top             =   360
      Width           =   855
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "±àºÅ·¶Î§"
      Height          =   375
      Left            =   1440
      TabIndex        =   2
      Top             =   8880
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub JsonMker_Click()
    Dim i As Integer
    Dim filepath As String
    filepath = "D:\LaoDAO\json\"
    For i = txt_start.Text To txt_end.Text
        Open filepath & i & ".json" For Output As #1
        Print #1, "{"
        Print #1, "    " & Chr(34) & "name" & Chr(34) & ": " & Chr(34) & txt_name.Text & i & Chr(34) & ","
        Print #1, "    " & Chr(34) & "image" & Chr(34) & ": " & Chr(34) & txt_image1.Text & i & ".png" & Chr(34) & ","
        Print #1, "    " & Chr(34) & "external_url" & Chr(34) & ": " & Chr(34) & txt_external_url.Text & Chr(34) & ","
        Print #1, "    " & Chr(34) & "description" & Chr(34) & ": " & Chr(34) & txt_description.Text & Chr(34) & ","
        'Print #1, "    " & Chr(34) & "attributes" & Chr(34) & ": " & Chr(34) & "["
        Print #1, txt_attr.Text
        Print #1, "            " & Chr(34) & "value" & Chr(34) & ": " & i + 1
        Print #1, "        }"
        Print #1, "    ]"
        Print #1, "}"
        Close #1
    Next i
    Label5.Caption = "OK!"
End Sub
