unit cell_logic;

interface
uses common_types;

function InitCell(x, y: byte; ch: char): TCell;
function RandomXYCell(ch: char): TCell;
procedure ShowCell(var Cell: TCell; Offset: TOffset);
procedure HideCell(var Cell: TCell; Offset: TOffset);

implementation
uses crt;

function InitCell(x, y: byte; ch: char): TCell;
begin
    InitCell.x := x;
    InitCell.y := y;
    InitCell.ch := ch;
    InitCell.shown := false
end;

function RandomXYCell(ch: char): TCell;
begin
    RandomXYCell.x := random(FieldWidth) + 1;
    RandomXYCell.y := random(FieldHeight) + 1;
    RandomXYCell.ch := ch;
    RandomXYCell.shown := false
end;

procedure ShowCell(var Cell: TCell; Offset: TOffset);
begin
    if Cell.shown then
        exit;
    GotoXY(Cell.x + Offset.x, Cell.y + Offset.y);
    write(Cell.ch);
    GotoXY(1, 1);
    Cell.shown := true
end;

procedure HideCell(var Cell: TCell; Offset: TOffset);
begin
    if not Cell.shown then
        exit;
    GotoXY(Cell.x + Offset.x, Cell.y + Offset.y);
    write(' ');
    GotoXY(1, 1);
    Cell.shown := false
end;

end.