VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTarefas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'3.7.0 Retirar prepara��o para tarefas din�micas
'3.1.2 Ajuste na convers�o das tar�fas
'2.7.5 Tar�fas Din�micas
'2.7.5 Retirada dos campos de tar�fas da tabela de or�amentos
Private TbOrcs As Recordset
Private DtUm   As Date

'3.7.0 Retirar prepara��o para tarefas din�micas
'Public Sub PrepTarDin(Objeto As Label)
'Dim a   As Integer
'Dim b   As Integer
'Dim SQL As String
'Dim M(4) As String
'
'M(0) = "Mec�nica"
'M(1) = "Chapea��o"
'M(2) = "Guarni��o"
'M(3) = "Pintura"
'M(4) = "Eletricidade"
'DtUm = DateSerial(2011, 10, 1)
'
'SQL = "SELECT Orcamento, Mecanica, Pintura, [Chapea��o], Eletricidade, [Guarni��o], Pagamento "
'SQL = SQL & "from Orcamento "
'SQL = SQL & "Where Mecanica > 0 Or Pintura > 0 Or [Chapea��o] > 0 Or Eletricidade > 0 Or [Guarni��o] > 0 "
'AbreTB TbOrcs, SQL, dbOpenForwardOnly
'Do While TbOrcs.EOF = False
'    a = a + 1
'    For b = 1 To 5
'        If TbOrcs.Fields(b).Value > 0 Then
'            InsereTarefa TbOrcs!Orcamento, b, TbOrcs.Fields(b).Value, SN(TbOrcs!Pagamento, vbDate)
'            Objeto.Caption = Trim(STR(a)) & " - " & M(b - 1)
'            Objeto.Refresh
'        End If
'    Next
'    TbOrcs.MoveNext
'Loop
'TbOrcs.Close
'INI.Versao = Trim(" " & App.Major & "." & App.Minor & "." & App.Revision)
'
''2.7.5 Retirada dos campos de tar�fas da tabela de or�amentos
'ExecSql "ALTER TABLE Orcamento DROP COLUMN Mecanica"
'ExecSql "ALTER TABLE Orcamento DROP COLUMN Pintura"
'ExecSql "ALTER TABLE Orcamento DROP COLUMN [Chapea��o]"
'ExecSql "ALTER TABLE Orcamento DROP COLUMN Eletricidade"
'ExecSql "ALTER TABLE Orcamento DROP COLUMN [Guarni��o]"
'
''3.0.7 Ajuste na adapta��o do programa para vers�o 3.0.7 pela base da vers�o 2.7.2.7
'ExecSql "Update Tarefas Set DtConclusao = Pago Where pago is not null "
'ExecSql "Update Tarefas Set DtConclusao = Now Where pago is null and situacao = 3 "
'End Sub

Private Sub InsereTarefa(NrOrc As Long, campo As Integer, Vlr As Currency, Pagto As Date)
Dim SQL As String

If Pagto > 0 Then
    SQL = "Insert Into Tarefas (Orc, Mec, Vlr, concerto, Situacao, Pago) Values( "
Else
    SQL = "Insert Into Tarefas (Orc, Mec, Vlr, concerto, Situacao) Values( "
End If
SQL = SQL & NrOrc & ","                                     'Orc
SQL = SQL & "0, "                                           'Mec
SQL = SQL & VlrSql(STR(Vlr)) & ","                          'Vlr,

'3.1.2 Ajuste na convers�o das tar�fas
SQL = SQL & (campo - 1) & ","                                   'concerto
'SQL = SQL & campo & ","                                     'concerto

If Pagto > 0 Then
    SQL = SQL & 3 & ","                                     'Situacao,
    SQL = SQL & DTSqls(Format(Pagto, "DD/MM/YYYY")) & ")"    'Pago,
Else
    SQL = SQL & 2 & ")"                                     'Situacao,
End If
ExecSql SQL
End Sub