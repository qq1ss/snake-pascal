unit offset_logic;

interface
uses common_types;

procedure InitOffset(var Offset: TOffset);

implementation
uses crt;

procedure InitOffset(var Offset: TOffset);
begin
    Offset.x := CenterScreenX - (FieldWidth div 2);
    Offset.y := CenterScreenY - (FieldHeight div 2)
end;

end.