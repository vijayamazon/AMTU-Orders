Set fso=CreateObject("Scripting.FileSystemObject")
Set objShell = WScript.CreateObject("WScript.Shell")
dim bcpname
Set fldr=fso.getFolder("c:\amazondata\production\reports")
for each file in fldr.files
	if instr(file,"ORDER") >0 then
		bcpname = "bcp amazondb.dbo.amazonORDERSTXT in " & file & " -c -F 2 -S 10.123.3.100 -m 1 -U admin -P abc123"
		wscript.echo bcpname
		Return = objShell.Run(bcpname, 1, true)
		fso.MoveFile file, "C:\amazoncomplete\"
	end if
next 