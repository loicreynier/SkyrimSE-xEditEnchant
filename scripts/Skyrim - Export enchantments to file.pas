{
    Export all enchantments records names to a text file

    Right click on one or several selected plugins.
    Made to generate a list for "Skyrim - Create enchanted items from CSV.pas".
}

unit userScript;

var
    slEnch: TStringList;

function Initialize: integer;
begin
    slEnch := TStringList.Create;
end;

function Process(e: IInterface): integer;
begin
    if Signature(e) <> 'ENCH' then exit;
    slEnch.Add(Name(e));
end;

function Finalize: integer;
var
    dlgSave: TSaveDialog;
begin
    if not Assigned(slEnch) then exit;
    if slEnch.Count > 1 then
    begin
        dlgSave := TSaveDialog.Create(nil);
        dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
        dlgSave.Filter := 'Text files (*.txt)|*.txt';
        dlgSave.InitialDir := ProgramPath;
        dlgSave.FileName := 'enchantments.txt';
        if dlgSave.Execute then
            slEnch.SaveToFile(dlgSave.Filename);
        dlgSave.Free;
    end;
    slEnch.Free;
end;

end.
