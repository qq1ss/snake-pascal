unit field_logic;

interface
uses common_types;

procedure CheckMinScreenSize();
procedure PrepareScreen(var SaveTextAttr: integer);

procedure InitBoarder(var Boarder: TBoarder);
procedure ShowBoarder(var Boarder: TBoarder; var Offset: TOffset);

implementation
uses crt;

procedure CheckMinScreenSize();
begin
    if (ScreenWidth <= MinScreenWidth) or
        (ScreenHeight <= MinScreenHeight) then
    begin
        writeln(ErrOutput, 'ERROR! Screen size is too small!');
        halt(1)
    end
end;

procedure PrepareScreen(var SaveTextAttr: integer);
begin
    SaveTextAttr := TextAttr;
    clrscr
end;

procedure InitBoarder(var Boarder: TBoarder);
begin
    Boarder.StartX := 0;
    Boarder.StartY := 0;
    Boarder.EndX := FieldWidth + 1;
    Boarder.EndY := FieldHeight + 1
end;

procedure ShowBoarder(var Boarder: TBoarder; var Offset: TOffset);
var
    x, y: byte;
begin
    for y := Boarder.StartY to Boarder.EndY do
    begin
        GotoXY(Boarder.StartX + Offset.x, y + Offset.y);
        if (y = Boarder.StartY) or (y = Boarder.EndY) then
        begin
            for x := Boarder.StartX to Boarder.EndX do
                write(BoarderChar)
        end
        else
        begin
            write(BoarderChar);
            GotoXY(Boarder.EndX + Offset.x, y + Offset.y);
            write(BoarderChar)
        end
    end;
    GotoXY(1, 1)
end;

end.