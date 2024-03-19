{
    Create enchanted items from a CSV file

    Right click on the base item and select the CSV file containing the
    enchantment list. The CSV must have the following format:

        EDID Suffix;Enchantement Full Name;Item Suffix;Charge Count

    The third value is considered a prefix if it ends with a space,
    otherwise it is considered a suffix.
    The charge count value is only required for enchanting weapons.

    As an example, running this script on `ArmorIronCuirass` from
    `Skyrim.esm` using the CSV file

        Alteration01;EnchArmorFortifyAlteration01 "Fortify Alteration" [ENCH:0007A107];of Minor Alteration
        Alteration02;EnchArmorFortifyAlteration02 "Fortify Alteration" [ENCH:000AD49F];of Alteration

    creates two new items/records:

        EnchArmorIronCuirassAlteration01 "Iron Armor of Minor Alteration" [ARMO:0010CFB8]
        EnchArmorIronCuirassAlteration02 "Iron Armor of Alteration" [ARMO:0010CFB9]

    The new records are written into the plugin providing the base item
    record.

    Using this script on multiple records at once is ill-advised.
}

unit userScript;

var
    slLines, slValues: TStringList;

function Initialize: integer;
var
    dlgOpen: TOpenDialog;
begin
    slLines := TStringList.Create;
    slValues := TStringList.Create;
    slValues.Delimiter := ';';
    slValues.StrictDelimiter := True;
    dlgOpen := TOpenDialog.Create(nil);
    dlgOpen.filter := 'Spreadsheet files (*.csv)|*.csv';
    if dlgOpen.Execute then begin
        slLines.LoadFromFile(dlgOpen.FileName);
    end;
    dlgOpen.Free;
end;

function Process(e: IInterface): integer;
var
    plugin, enchItem: IInterface;
    i: integer;
id: string;
begin
    if (Signature(e) <> 'ARMO') and (Signature(e) <> 'WEAP') then begin
        AddMessage(Name(e) + ' not an armor or weapon record, nothing to do');
    end;
    if GetElementEditValues(e, 'EITM') <> '' then begin
        AddMessage(Name(e) + ' is already enchanted, nothing to do');
        exit;
    end;
    plugin := GetFile(e);
    for i:= 0 to slLines.Count-1 do
    begin
        slValues.DelimitedText := slLines[i];
        enchItem := wbCopyElementToFile(e, GetFile(e), True, True);
        id := 'Ench' + GetElementEditValues(e, 'EDID') + slValues[0];
        if RightStr(slValues[2], 1) = ' ' then begin
            SetElementEditValues(enchItem, 'FULL',
                slValues[2] + GetElementEditValues(enchItem, 'FULL'));
        end else begin
            SetElementEditValues(enchItem, 'FULL',
                GetElementEditValues(enchItem, 'FULL') + ' ' + slValues[2]);
        end;
        SetElementEditValues(enchItem, 'EDID', id);
        if Signature(e) = 'WEAP' then begin
            Add(enchItem, 'CNAM', True);
            SetElementEditValues(enchItem, 'CNAM', Name(e));
            SetElementEditValues(enchItem, 'EAMT', slValues[3]);
        end else if Signature(e) = 'ARMO' then begin
            Add(enchItem, 'TNAM', True);
            SetElementEditValues(enchItem, 'TNAM', Name(e));
        end;
        Add(enchItem, 'EITM', True);
        SetElementEditValues(enchItem, 'EITM', slValues[1]);
        AddMessage(id + ' created');
    end;
end;

end.
